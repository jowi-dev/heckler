defmodule Heckler.Scheduler do
  @moduledoc """
  Schedules notifications and manages delivery timing.

  The Scheduler module is the core foundation of Heckler's notification scheduling system.
  It provides functions to send messages immediately or schedule them for future delivery,
  with all notifications being recorded in a database for tracking and auditing.

  ## Features

  * **Immediate Delivery**: Send notifications right away while still recording them
  * **Future Scheduling**: Schedule notifications for a specific time in the future
  * **Notification Tracking**: All notifications are recorded in the database
  * **Retry Management**: Built-in retry logic for failed notifications

  ## Dependencies

  The Scheduler requires [Oban](https://github.com/sorentwo/oban) for job scheduling
  and persistence. Make sure to add Oban to your dependencies and configure it properly:

  ```elixir
  # In mix.exs
  def deps do
    [
      {:oban, "~> 2.15"}
    ]
  end

  # In config/config.exs
  config :your_app, Oban,
    repo: YourApp.Repo,
    plugins: [Oban.Plugins.Pruner],
    queues: [notifications: 10]
  ```

  ## Database Setup

  The Scheduler stores notifications in the database using the `Heckler.Notification` schema.
  You need to run the Heckler migrations to create the required tables:

  ```bash
  mix heckler.gen.migrations
  mix ecto.migrate
  ```
  """

  @doc """
  Schedules an SMS to be sent at a specific time in the future.

  This function creates an Oban job that will execute at the specified time,
  sending the SMS message and recording it in the notifications table.

  ## Parameters
    - `to`: The phone number to send the message to (E.164 format, e.g., "+15551234567")
    - `message`: The message content
    - `scheduled_at`: `DateTime` when the message should be sent
    - `opts`: Additional options for the notification
    
  ## Options
    - `:status_callback`: URL for delivery status callbacks
    - `:metadata`: Map of additional data to store with the notification
    - `:from`: Specific sender phone number (if different from default)

  ## Returns
    - `{:ok, job}` if scheduling was successful, where `job` is the Oban job
    - `{:error, reason}` if scheduling failed
    
  ## Examples

  ```elixir
  # Schedule an SMS for 1 hour from now
  scheduled_at = DateTime.utc_now() |> DateTime.add(3600, :second)
  Heckler.Scheduler.schedule_sms(
    "+15551234567", 
    "Your appointment is in 1 hour!", 
    scheduled_at
  )

  # Schedule with additional metadata
  Heckler.Scheduler.schedule_sms(
    "+15551234567",
    "Your order #12345 has shipped!",
    ~U[2023-12-25 10:00:00Z],
    metadata: %{order_id: "12345", tracking_number: "TN123456789"}
  )
  ```

  ## Error Handling

  If Oban is not available, this function returns an error:

  ```elixir
  {:error, "Oban is not available. Please add it to your dependencies and configure it."}
  ```
  """
  def schedule_sms(to, message, scheduled_at, opts \\ []) do
    if oban_available?() do
      %{
        to: to,
        message: message,
        scheduled_at: scheduled_at,
        options: Enum.into(opts, %{}),
        adapter: Heckler.Adapters.Twilio
      }
      |> Heckler.Workers.SMSWorker.new(schedule_in: time_until(scheduled_at))
      |> Oban.insert()
    else
      {:error, "Oban is not available. Please add it to your dependencies and configure it."}
    end
  end

  @doc """
  Sends an SMS immediately and records it in the database.

  Unlike `Heckler.SMS.send/2`, this function records the notification in the
  database using Oban, providing tracking and audit capabilities. If Oban is
  not available, it falls back to sending the message directly through the adapter.

  ## Parameters
    - `to`: The phone number to send the message to (E.164 format, e.g., "+15551234567")
    - `message`: The message content
    - `opts`: Additional options for the notification
    
  ## Options
    - `:status_callback`: URL for delivery status callbacks
    - `:metadata`: Map of additional data to store with the notification
    - `:from`: Specific sender phone number (if different from default)

  ## Returns
    - `{:ok, job}` if using Oban, where `job` is the Oban job
    - `{:ok, response}` if not using Oban, where `response` is the adapter response
    - `{:error, reason}` on failure
    
  ## Examples

  ```elixir
  # Send an SMS immediately with tracking
  Heckler.Scheduler.send_sms_now(
    "+15551234567", 
    "Your verification code is 123456"
  )

  # Send with custom metadata
  Heckler.Scheduler.send_sms_now(
    "+15551234567",
    "Your password has been reset",
    metadata: %{event: "password_reset", user_id: 42}
  )
  ```
  """
  def send_sms_now(to, message, opts \\ []) do
    # If Oban is available, we log the notification even for immediate delivery
    if oban_available?() do
      %{
        to: to,
        message: message,
        options: Enum.into(opts, %{}),
        adapter: Heckler.Adapters.Twilio
      }
      |> Heckler.Workers.SMSWorker.new()
      |> Oban.insert()
    else
      Heckler.Adapters.Twilio.send_sms(to, message)
    end
  end

  # Private helper functions

  @doc false
  defp oban_available? do
    Code.ensure_loaded?(Oban) && function_exported?(Oban, :insert, 1)
  end

  @doc false
  defp time_until(%DateTime{} = scheduled_time) do
    now = DateTime.utc_now()
    DateTime.diff(scheduled_time, now, :second)
  end
end
