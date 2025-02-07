defmodule Heckler.Adapters.Twilio do
  @moduledoc false
  @behaviour Heckler.SMS

  alias Heckler.Adapters.Twilio.Connection
  alias Heckler.Adapters.Twilio.Api.Message
  def send_sms(to, message) do
    account_sid = Application.get_env(__MODULE__, :account_sid)
    auth_token  = Application.get_env(__MODULE__,  :auth_token)
    msg_srv_sid  = Application.get_env(__MODULE__,  :msg_srv_sid)

    to = "+15023206035"

    opts = [username: account_sid, password: auth_token]
    Connection.new(opts)
    |> Message.create_message(account_sid, to, [ 
      To: to,
      Body: message,
      MessageServiceSid: msg_srv_sid
    ])
  end
end
