import Config

# config :heckler, Heckler.APNS,
#  adapter: Pigeon.APNS,
#  cert: File.read!("cert.pem"),
#  key: File.read!("cert.pem"),
#  mode: :dev

# Or for token based authentication:

config :heckler, Heckler.APNS,
  adapter: Pigeon.APNS,
  key: File.read!("AuthKey.p8"),
  key_identifier: "5XRLTUCS24",
  mode: :dev,
  team_id: "UPX69FSX5H"

# Use Hackney adapter which has better support for form encoding
config :tesla, adapter: Tesla.Adapter.Hackney

# Configure Tesla HTTP options for Twilio connection
config :tesla, Heckler.Adapters.Twilio.Connection, adapter: Tesla.Adapter.Hackney
