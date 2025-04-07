# Heckler

[![Hex.pm](https://img.shields.io/hexpm/v/heckler.svg)](https://hex.pm/packages/heckler)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/heckler/)
[![License](https://img.shields.io/hexpm/l/heckler.svg)](https://github.com/yourusername/heckler/blob/main/LICENSE)

Heckler is a notification library for Elixir applications that makes it easy to send and schedule SMS and push notifications.

## Features

* **SMS Messaging**: Send SMS messages using Twilio
* **Scheduled Notifications**: Schedule messages for future delivery using Oban
* **APNS Support**: Send push notifications to Apple devices (coming soon)
* **Notification Tracking**: All notifications are stored in the database for auditing
* **Flexible Architecture**: Add custom adapters for different messaging providers

## Installation

Add Heckler to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:heckler, "~> 0.1.0"},
    {:oban, "~> 2.15"}, # Required for scheduling functionality
    {:jason, "~> 1.0"}, # Required for JSON encoding/decoding
    
    # Only needed if using certain adapters:
    {:httpoison, "~> 2.0"}, # Required for Twilio adapter
    {:pigeon, "~> 2.0"} # Required for APNS adapter (coming soon)
  ]
end
```

## Setup

### 1. Generate Migrations

Run the migration generator to create the required database tables:

```shell
mix heckler.gen.migrations
mix ecto.migrate
```

### 2. Configure Adapters

#### Twilio SMS

```elixir
# In config/config.exs or config/runtime.exs
config :your_app, Heckler.Adapters.Twilio,
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
  auth_token: System.get_env("TWILIO_AUTH_TOKEN"),
  from_number: System.get_env("TWILIO_FROM_NUMBER"),
  message_service_sid: System.get_env("TWILIO_MESSAGE_SERVICE_SID")
```

### 3. Configure Heckler

```elixir
config :your_app, Heckler,
  sms_adapter: Heckler.Adapters.Twilio
```

### 4. Configure Oban for Scheduling

```elixir
config :your_app, Oban,
  repo: YourApp.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [notifications: 10]
```

### 5. Add to Supervision Tree

```elixir
# In your application.ex
def start(_type, _args) do
  children = [
    # ...other children
    {Heckler, []}
  ]
  
  Supervisor.start_link(children, strategy: :one_for_one, name: YourApp.Supervisor)
end
```

## Usage

### Sending an SMS Immediately

```elixir
# Using the basic interface
Heckler.SMS.send("+15551234567", "Hello from Heckler!")

# Using the scheduler (records notification in database)
Heckler.Scheduler.send_sms_now("+15551234567", "Hello with tracking!")
```

### Scheduling an SMS for Later

```elixir
# Schedule an SMS for 30 minutes from now
scheduled_time = DateTime.utc_now() |> DateTime.add(30, :minute)
Heckler.Scheduler.schedule_sms("+15551234567", "This is a scheduled message", scheduled_time)

# Schedule with metadata
Heckler.Scheduler.schedule_sms(
  "+15551234567",
  "Your order has shipped!",
  ~U[2023-12-25 12:00:00Z],
  metadata: %{order_id: "123456"}
)
```

### Custom Adapters

You can easily create custom SMS adapters:

```elixir
defmodule MyApp.CustomSMSAdapter do
  @behaviour Heckler.SMS
  
  def send_sms(to, message) do
    # Your implementation here
    # Must return {:ok, response} or {:error, reason}
  end
end

# Configure Heckler to use your adapter
config :your_app, Heckler,
  sms_adapter: MyApp.CustomSMSAdapter
```

## Documentation

Complete documentation is available at [https://hexdocs.pm/heckler](https://hexdocs.pm/heckler).

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

- [Oban](https://github.com/sorentwo/oban) for job scheduling
- [HTTPoison](https://github.com/edgurgel/httpoison) for HTTP requests
- [Pigeon](https://github.com/codedge-llc/pigeon) for APNS integration

