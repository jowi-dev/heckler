defmodule Heckler.Adapters.Twilio do
  @moduledoc """
  Twilio SMS adapter for Heckler.

  This adapter implements the `Heckler.SMS` behavior and provides
  integration with Twilio's Programmable Messaging API. It allows
  sending SMS messages through Twilio's service with comprehensive
  error handling and logging.

  ## Configuration

  The adapter requires configuration in your application:

  ```elixir
  # In config/config.exs or config/runtime.exs
  config :your_app, Heckler.Adapters.Twilio,
    account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
    auth_token: System.get_env("TWILIO_AUTH_TOKEN"),
    from_number: System.get_env("TWILIO_FROM_NUMBER"),         # Optional, can use MessageService instead
    message_service_sid: System.get_env("TWILIO_MESSAGE_SERVICE_SID")  # Optional
  ```

  You must provide at least:
  1. `account_sid` - Your Twilio account SID 
  2. `auth_token` - Your Twilio auth token
  3. Either `from_number` or `message_service_sid`

  ## Usage

  This adapter is used automatically when configured with Heckler:

  ```elixir
  # Configure Heckler to use the Twilio adapter
  config :your_app, Heckler,
    sms_adapter: Heckler.Adapters.Twilio

  # Then send messages using Heckler.SMS
  Heckler.SMS.send("+15551234567", "Hello from Twilio!")
  ```

  You can also use the adapter directly:

  ```elixir
  Heckler.Adapters.Twilio.send_sms("+15551234567", "Direct adapter usage")
  ```

  ## Phone Number Format

  Phone numbers should be in E.164 format (e.g., "+15551234567").
  If the `+` prefix is missing, the adapter will automatically add it.

  ## Response Format

  On success, the adapter returns:

  ```elixir
  {:ok, %{
    "sid" => "SM...",  # Twilio message SID
    "status" => "queued",  # Message status
    # ...other response fields from Twilio
  }}
  ```

  On failure, it returns:

  ```elixir
  {:error, %{
    "code" => 21211,  # Error code from Twilio
    "message" => "The 'To' number is not a valid phone number",
    "more_info" => "https://www.twilio.com/docs/errors/21211",
    "status" => 400
  }}
  ```

  ## Debug Logging

  The adapter logs request parameters and responses for debugging purposes.
  These logs are helpful for troubleshooting message delivery issues.
  """
  @behaviour Heckler.SMS

  require Logger
  @twilio_api_url "https://api.twilio.com/2010-04-01/Accounts/"

  @doc """
  Sends an SMS message through Twilio's Programmable Messaging API.

  This function implements the `Heckler.SMS` behavior and handles the full
  lifecycle of sending an SMS via Twilio, from validation to response handling.

  ## Parameters
    - `to`: The phone number to send the message to (should be in E.164 format, e.g., "+15551234567")
    - `message`: The message content to send

  ## Returns
    - `{:ok, response}` on success, where `response` is the parsed JSON response from Twilio
    - `{:error, reason}` on failure, where `reason` contains error details
    
  ## Error Handling

  Various error conditions are handled:

  - Missing configuration: Returns `{:error, "Twilio credentials not configured..."}`
  - Invalid phone number: Returns the error from Twilio with code 21211
  - Network errors: Returns the error with connection details
  - API errors: Returns the error response from Twilio

  ## Examples

  ```elixir
  # Send a simple message
  Heckler.Adapters.Twilio.send_sms("+15551234567", "Hello from Twilio!")

  # Handle the response
  case Heckler.Adapters.Twilio.send_sms("+15551234567", "Hello!") do
    {:ok, response} ->
      # Message sent successfully
      Logger.info("Message sent with SID: \#{response["sid"]}")
      
    {:error, %{"code" => code, "message" => message}} ->
      # Twilio API error
      Logger.error("Twilio error \#{code}: \#{message}")
      
    {:error, other_error} ->
      # Other error (connection, etc.)
      Logger.error("Error sending SMS: \#{inspect(other_error)}")
  end
  ```
  """
  def send_sms(to, message) do
    app_name = Mix.Project.config()[:app]
    config = Application.get_env(app_name, __MODULE__) || []
    account_sid = config[:account_sid]
    auth_token = config[:auth_token]
    msg_srv_sid = config[:message_service_sid]
    from_number = config[:from_number]

    if is_nil(account_sid) || is_nil(auth_token) do
      {:error, "Twilio credentials not configured. Please set account_sid and auth_token."}
    else
      # Ensure phone number is in E.164 format (e.g., "+15551234567")
      formatted_to = if String.starts_with?(to, "+"), do: to, else: "+#{to}"

      # Build form params for the request
      form_params = [
        {"To", formatted_to},
        {"Body", message}
      ]

      # Add MessagingServiceSid or From number based on configuration
      form_params = add_sender_parameters(form_params, msg_srv_sid, from_number)

      # Prepare authentication and headers
      basic_auth = {account_sid, auth_token}
      headers = [{"Content-Type", "application/x-www-form-urlencoded"}]

      # Log request information for debugging
      IO.inspect(form_params, label: "Twilio Request Parameters")

      # Make the actual HTTP request
      url = "#{@twilio_api_url}#{account_sid}/Messages.json"

      case HTTPoison.post(url, {:form, form_params}, headers, hackney: [basic_auth: basic_auth]) do
        {:ok, %{status_code: status, body: body}} when status in 200..299 ->
          # Successfully sent the message
          parsed_response = Jason.decode!(body)
          IO.inspect(parsed_response, label: "Twilio Success Response")
          {:ok, parsed_response}

        {:ok, %{status_code: status, body: body}} ->
          # Received an error from Twilio
          error =
            case Jason.decode(body) do
              {:ok, parsed} -> parsed
              _ -> %{"message" => "Failed to parse error response", "original" => body}
            end

          IO.inspect(error, label: "Twilio Error (Status #{status})")
          {:error, error}

        {:error, %HTTPoison.Error{reason: reason}} ->
          # HTTP request failed
          IO.inspect(reason, label: "HTTP Request Error")
          {:error, reason}
      end
    end
  end

  @doc false
  defp add_sender_parameters(form_params, msg_srv_sid, from_number) do
    cond do
      # If message service SID is configured, use it
      !is_nil(msg_srv_sid) ->
        form_params ++ [{"MessagingServiceSid", msg_srv_sid}]

      # Otherwise, if from number is configured, use that
      !is_nil(from_number) ->
        form_params ++ [{"From", from_number}]

      # If neither is configured, keep original params (will probably fail)
      true ->
        form_params
    end
  end
end
