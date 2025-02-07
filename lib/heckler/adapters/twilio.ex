defmodule Heckler.Adapters.Twilio do
  @moduledoc false
  @behaviour Heckler.SMS

  def send_sms(to, message) do
    auth_result = authenticate()
    |> IO.inspect(limit: :infinity, pretty: true, label: "")

  end

  defp authenticate do
    account_sid = Application.get_env(__MODULE__, :account_sid)
    auth_token  = Application.get_env(__MODULE__,  :auth_token)

    Req.get!("https://api.twilio.com/2010-04-01/Accounts", auth: {:basic, "#{account_sid}:#{auth_token}"})
  end
end
