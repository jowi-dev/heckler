defmodule Heckler.SMS do
  @moduledoc """
  Heckler.SMS provides a simple interface for sending SMS messages.
  It does this by providing a thin abstraction over possible abstractions.
  New adapters can be easily added by implementing the `Heckler.SMS` behaviour.
  """
  @callback send_sms(to :: String.t(), message :: String.t()) :: {:ok, map()} | {:error, term()}

  @doc """
  Sends an SMS message using the configured adapter.

  ## Parameters
    - to: The phone number to send the message to (should be in E.164 format)
    - message: The message content

  ## Returns
    - `{:ok, response}` on success
    - `{:error, reason}` on failure

  ## Configuration
  To configure the SMS adapter, add the following to your config:

  ```elixir
  config :your_app, Heckler,
    sms_adapter: YourApp.SMS.Adapter
  ```
  
  The adapter should implement the `Heckler.SMS` behaviour.
  """
  def send(to, message) do
    case get_sms_adapter() do
      nil ->
        {:error, "No SMS adapter configured. Configure one with config :your_app, Heckler, sms_adapter: YourAdapter"}
      
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
