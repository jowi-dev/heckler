import Config

# Define Ecto repositories
config :heckler, ecto_repos: [Heckler.DevRepo]

# Configure Heckler for development
if config_env() in [:dev, :test] do
  # Set up PostgreSQL for development/testing
  config :heckler, Heckler.DevRepo,
    username: "postgres",
    password: "postgres",
    database: "heckler_dev",
    hostname: "localhost",
    port: 5432,
    pool_size: 10,
    adapter: Ecto.Adapters.Postgres

  # Set up Oban for development/testing
  config :heckler, Oban,
    repo: Heckler.DevRepo,
    plugins: [Oban.Plugins.Pruner],
    queues: [notifications: 10]

  # Configure Heckler to use its own Twilio adapter
  config :heckler, Heckler,
    sms_adapter: Heckler.Adapters.Twilio
end

# Configure Twilio adapter from environment variables
config :heckler, Heckler.Adapters.Twilio, [
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
  auth_token: System.get_env("TWILIO_AUTH_TOKEN"),
  from_number: System.get_env("TWILIO_FROM_NUMBER"),
  message_service_sid: System.get_env("TWILIO_MESSAGE_SERVICE_SID")
]

# APNS configuration for token based authentication
config :heckler, Heckler.APNS,
  adapter: Pigeon.APNS,
  key: System.get_env("APNS_AUTH_KEY") || "",
  key_identifier: System.get_env("APNS_KEY_IDENTIFIER") || "",
  mode: :dev,
  team_id: System.get_env("APNS_TEAM_ID") || ""

# Use Hackney adapter which has better support for form encoding
config :tesla, adapter: Tesla.Adapter.Hackney

# Configure Tesla HTTP options for Twilio connection
config :tesla, Heckler.Adapters.Twilio.Connection, adapter: Tesla.Adapter.Hackney
