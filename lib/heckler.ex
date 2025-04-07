defmodule Heckler do
  use Supervisor

  @moduledoc """
  # Heckler

  Heckler is a notification library for Elixir applications that makes it easy to send 
  and schedule SMS and push notifications.

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
      {:heckler, "~> 0.1.0"}
    ]
  end
  ```

  ## Setup

  1. **Generate Migrations**: 
     
     ```shell
     mix heckler.gen.migrations
     ```

  2. **Configure Twilio**:

     ```elixir
     # In your config/config.exs or config/runtime.exs
     config :your_app, Heckler.Adapters.Twilio,
       account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
       auth_token: System.get_env("TWILIO_AUTH_TOKEN"),
       from_number: System.get_env("TWILIO_FROM_NUMBER"),
       message_service_sid: System.get_env("TWILIO_MESSAGE_SERVICE_SID")
     ```

  3. **Configure Heckler**:

     ```elixir
     config :your_app, Heckler,
       sms_adapter: Heckler.Adapters.Twilio
     ```

  4. **Configure Oban** (for scheduled notifications):

     ```elixir
     config :your_app, Oban,
       repo: YourApp.Repo,
       plugins: [Oban.Plugins.Pruner],
       queues: [notifications: 10]
     ```

  5. **Add to Supervision Tree**:

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

  ## Usage Examples

  ### Sending an SMS

  ```elixir
  # Send an SMS immediately
  Heckler.SMS.send("+15551234567", "Hello from Heckler!")

  # Using scheduler to record the notification
  Heckler.Scheduler.send_sms_now("+15551234567", "Hello with tracking!")
  ```

  ### Scheduling an SMS

  ```elixir
  # Schedule an SMS for 30 minutes from now
  scheduled_time = DateTime.utc_now() |> DateTime.add(30, :minute)
  Heckler.Scheduler.schedule_sms("+15551234567", "This is a scheduled message", scheduled_time)
  ```
  """

  @spec start_link([Supervisor.option()]) :: Supervisor.on_start()
  @doc """
  Starts the Heckler supervisor.

  This function is used when adding Heckler to your application's supervision tree.

  ## Example

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
  """
  def start_link(opts) when is_list(opts) do
    sup_opts = [strategy: :one_for_one, name: Heckler]
    Supervisor.start_link(__MODULE__, opts, sup_opts)
  end

  @doc false
  def init(_opts) do
    children = [
      {Heckler.APNS, apns_opts()}
    ]

    Supervisor.init(children, strategy: :one_for_one, name: Heckler.Supervisor)
  end

  @doc false
  @spec child_spec([Supervisor.option()]) :: Supervisor.child_spec()
  def child_spec(opts) do
    opts
    |> super()
    |> Supervisor.child_spec(id: Keyword.get(opts, :name, __MODULE__))
  end

  defp apns_opts do
    [
      adapter: Pigeon.APNS,
      key: File.read!(System.get_env("APNS_AUTH_KEY_PATH")),
      key_identifier: System.get_env("APNS_KEY_IDENTIFIER"),
      mode: :dev,
      team_id: System.get_env("APNS_TEAM_ID")
    ]
  end

  # -----------------------------------------------------------------------------
  #  if we decide to go back to using a macro style library I'll uncomment
  # and pull this back into usage. For now function calls make way more sense
  # -----------------------------------------------------------------------------
  #  defmacro __using__(_opts) do
  #    caller = List.first(__CALLER__.context_modules)
  #    quote do
  #      def hello() do
  #        app = Application.get_application(unquote(caller))
  #        Application.get_env(app, Heckler)
  #      end
  #    end
  #  end
end
