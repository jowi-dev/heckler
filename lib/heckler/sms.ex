defmodule Heckler.SMS do
  @moduledoc """
  Heckler.SMS provides a simple interface for sending SMS messages.
  It does this by providing a thin abstraction over possible abstractions.
  New adapters can be easily added by implementing the `Heckler.SMS` behaviour.
  """
  @callback send_sms(to :: String.t(), message :: String.t()) :: {:ok, map()} | {:error, term()}

  def send(to, message) do
    sms_adapter = Application.get_env(:heckler, Heckler)[:sms_adapter]

    sms_adapter.send_sms(to, message)
  end
end
