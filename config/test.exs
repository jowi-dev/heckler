import Config

# Configure Heckler to use the mock adapter for SMS in tests
config :heckler, Heckler, sms_adapter: SMSMock

# Make the adapter available via String.to_existing_atom in SMS worker
config :heckler, :test_adapters, [
  SMSMock
]

# Configure Oban for testing
config :heckler, Oban,
  queues: false,
  plugins: false
