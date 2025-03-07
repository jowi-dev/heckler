defmodule Heckler.Adapters.Twilio do
  @moduledoc """
  A simple Twilio adapter for Heckler that uses HTTPoison directly
  for better control and simpler debugging.
  """
  @behaviour Heckler.SMS

  @twilio_api_url "https://api.twilio.com/2010-04-01/Accounts/"

  @doc """
  Sends an SMS message through Twilio's API.

  ## Parameters
    - to: The phone number to send the message to (should be in E.164 format)
    - message: The message content

  ## Returns
    - `{:ok, response}` on success
    - `{:error, reason}` on failure
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
        {"Body", message},
        {"MessagingServiceSid", msg_srv_sid}
      ]

      # Add From number if configured
      form_params =
        if is_nil(from_number) do
          form_params
        else
          form_params ++ [{"From", from_number}]
        end

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
end
