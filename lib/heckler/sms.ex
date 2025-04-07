defmodule Heckler.SMS do
  @moduledoc """
  A behavior and module for sending SMS messages through various adapters.

  `Heckler.SMS` provides a simple interface for sending SMS messages through
  different service providers. By default, Heckler includes a Twilio adapter,
  but you can implement custom adapters for other SMS providers.

  ## Adapter Behavior

  All SMS adapters must implement the `Heckler.SMS` behavior, which requires
  a `send_sms/2` function that takes a phone number and message content.

  ## Configuration

  To configure which SMS adapter Heckler should use:

  ```elixir
  # In your config/config.exs
  config :your_app, Heckler,
    sms_adapter: Heckler.Adapters.Twilio
  ```

  Each adapter will also have its own configuration. For example, the Twilio adapter:

  ```elixir
  config :your_app, Heckler.Adapters.Twilio,
    account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
    auth_token: System.get_env("TWILIO_AUTH_TOKEN"),
    from_number: System.get_env("TWILIO_FROM_NUMBER"),
    message_service_sid: System.get_env("TWILIO_MESSAGE_SERVICE_SID")
  ```

  ## Creating a Custom Adapter

  To create a custom SMS adapter, implement the `Heckler.SMS` behavior:

  ```elixir
  defmodule MyApp.CustomSMSAdapter do
    @behaviour Heckler.SMS
    
    def send_sms(to, message) do
      # Your implementation logic here
      # Must return {:ok, response} or {:error, reason}
    end
  end
  ```

  Then configure Heckler to use your adapter:

  ```elixir
  config :your_app, Heckler,
    sms_adapter: MyApp.CustomSMSAdapter
  ```
  """

  @doc """
  Callback for sending an SMS message.

  Implementations must return `{:ok, response}` on success or `{:error, reason}` on failure.
  The `response` is typically a map containing details about the sent message.
  """
  @callback send_sms(to :: String.t(), message :: String.t()) :: {:ok, map()} | {:error, term()}

  @doc """
  Sends an SMS message using the configured adapter.

  This function uses the adapter configured in your application to send SMS messages.
  If no adapter is configured, it returns an error.

  ## Parameters
    - `to`: The phone number to send the message to (should be in E.164 format, e.g. "+15551234567")
    - `message`: The message content

  ## Returns
    - `{:ok, response}` on success, where response is a map containing details about the sent message
    - `{:error, reason}` on failure

  ## Examples

  ```elixir
  # Send a simple message
  Heckler.SMS.send("+15551234567", "Hello from Heckler!")
  #=> {:ok, %{"sid" => "SM123456", "status" => "queued"}}

  # Handle potential errors
  case Heckler.SMS.send("+15551234567", "Important message") do
    {:ok, response} ->
      Logger.info("Message sent with ID: \#{response["sid"]}")
    
    {:error, reason} ->
      Logger.error("Failed to send message: \#{inspect(reason)}")
  end
  ```
  """
  def send(to, message) do
    case get_sms_adapter() do
      nil ->
        {:error,
         "No SMS adapter configured. Configure one with config :your_app, Heckler, sms_adapter: YourAdapter"}

      adapter when is_atom(adapter) ->
        adapter.send_sms(to, message)
    end
  end

  # Try to get the SMS adapter from various possible configurations
  defp get_sms_adapter do
    app = Application.get_application(__MODULE__) || :heckler

    # First check for adapter in host application's config
    config = Application.get_env(app, Heckler) || []
    adapter = config[:sms_adapter]

    # Fall back to directly configured adapter in development/test
    if is_nil(adapter) && (Mix.env() == :dev || Mix.env() == :test) do
      Application.get_env(:heckler, __MODULE__)[:adapter]
    else
      adapter
    end
  end
end
