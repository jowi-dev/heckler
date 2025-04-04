defmodule Heckler.Scheduler do
  @moduledoc """
  This module is the core foundation to Heckler. It determines the appropriate scheduling engine
  and schedules notifications to be sent.

  Heckler supports two scheduling methods:
  1. Immediate delivery (no scheduler required)
  2. Scheduled delivery using Oban (requires Oban and Ecto in the host application)

  All sent notifications are recorded in the database when using Oban scheduling.
  """

  @doc """
  Schedule an SMS to be sent at a specific time.
  
  ## Parameters
    - to: The phone number to send the message to (E.164 format)
    - message: The message content
    - scheduled_at: DateTime when the message should be sent
    - opts: Additional options for the notification
    
  ## Options
    - status_callback: URL for delivery status callbacks
    - metadata: Map of additional data to store with the notification

  ## Returns
    - `{:ok, job}` if scheduling was successful
    - `{:error, reason}` otherwise
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
  Send an SMS immediately.
  
  This doesn't require a scheduler but will still record the notification
  in the database if Oban is configured.
  
  ## Parameters
    - to: The phone number to send the message to (E.164 format)
    - message: The message content
    - opts: Additional options for the notification
    
  ## Options
    - status_callback: URL for delivery status callbacks
    - metadata: Map of additional data to store with the notification

  ## Returns
    - `{:ok, response}` on success
    - `{:error, reason}` on failure
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

  defp oban_available? do
    Code.ensure_loaded?(Oban) && function_exported?(Oban, :insert, 1)
  end

  defp time_until(%DateTime{} = scheduled_time) do
    now = DateTime.utc_now()
    DateTime.diff(scheduled_time, now, :second)
  end
end
