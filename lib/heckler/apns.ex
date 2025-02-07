defmodule Heckler.APNS do
  @moduledoc false
  use Pigeon.Dispatcher, otp_app: :heckler

  def test_pn do
    notification = Pigeon.APNS.Notification.new("Hello world", "66da0125a857f32100a3cfb2ca9688252b8aa737469596a40a735c5c2c017df6", "family-recipe")
    Heckler.APNS.push(notification)
  end
end
