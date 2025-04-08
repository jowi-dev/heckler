defmodule Heckler.Workers.SMSWorker do
  @moduledoc """
  Oban worker for sending and tracking SMS messages.

  This worker is responsible for both immediate and scheduled SMS delivery.
  It handles:

  * Sending SMS messages through the configured adapter
  * Recording notification details in the database
  * Updating notification status after delivery attempts
  * Retrying failed deliveries with exponential backoff
  * Logging delivery results for debugging

  The worker is meant to be used internally by the `Heckler.Scheduler` module,
  but can also be used directly if you need more control over the job options.

  ## Job Arguments

  The worker expects the following arguments in the Oban job:

  * `"to"` - The recipient phone number (E.164 format)
  * `"message"` - The SMS content
  * `"adapter"` - (Optional) The SMS adapter module to use
  * `"options"` - (Optional) Additional options for the notification
  * `"scheduled_at"` - (Optional) ISO-8601 timestamp for scheduled delivery

  ## Options

  The `"options"` map can contain:

  * `"from"` - The sender phone number
  * `"status_callback"` - URL for delivery status webhooks
  * `"metadata"` - Any additional data to store with the notification

  ## Example Usage

  ```elixir
  # Create and enqueue a job
  %{
    to: "+15551234567",
    message: "Hello, world!",
    options: %{metadata: %{user_id: 123}}
  }
  |> Heckler.Workers.SMSWorker.new()
  |> Oban.insert()

  # Schedule an SMS for future delivery
  scheduled_at = DateTime.utc_now() |> DateTime.add(3600, :second)

  %{
    to: "+15551234567",
    message: "This is a scheduled message",
    scheduled_at: scheduled_at,
    options: %{metadata: %{scheduled: true}}
  }
  |> Heckler.Workers.SMSWorker.new(schedule_in: 3600)
  |> Oban.insert()
  ```

  ## Retries and Error Handling

  The worker is configured for 3 retry attempts with exponential backoff.
  After the final retry, the message will be marked as permanently failed
  in the database, but the job will complete successfully to avoid polluting
  the Oban error metrics.
  """

  use Oban.Worker, queue: :notifications, max_attempts: 3

  require Logger
  alias Heckler.Notification

  @doc """
  Processes an SMS job.

  This function is called by Oban when the job is due to be executed.
  It extracts the necessary information from the job arguments,
  creates a notification record in the database, and then attempts
  to send the SMS through the configured adapter.

  The function will properly update the notification record with the
  result of the delivery attempt and handle any errors according to
  the retry configuration.

  ## Parameters
    - `job`: The Oban.Job struct containing job information and arguments

  ## Returns
    - `{:ok, response}` on successful delivery, where response contains details from the adapter
    - `{:error, reason}` if delivery failed and should be retried
    - `{:ok, %{error: error, status: "permanently_failed"}}` if all retry attempts failed
  """
  @impl Oban.Worker
  def perform(%Oban.Job{args: args} = job) do
    %{
      "to" => to,
      "message" => message
    } = args

    # Get the adapter module (default to Twilio)
    adapter_module = get_adapter_module()

    # Extract options
    options = Map.get(args, "options", %{})
    scheduled_at = Map.get(args, "scheduled_at")

    # First, create a notification record
    notification_attrs = %{
      scheduled_at: parse_scheduled_at(scheduled_at),
      from: options["from"],
      metadata: options
    }

    notification =
      Notification.new_sms(to, message, notification_attrs)
      |> handle_notification_record()

    # Log the attempt
    Logger.info("Sending SMS to #{to} with message: #{message}")

    # Send the message using the specified adapter
    case adapter_module.send_sms(to, message) do
      {:ok, response} ->
        Logger.info("Successfully sent SMS to #{to}")

        # Update the notification record with success status
        provider_id = response["sid"] || response["id"] || response["message_id"]
        update_notification(notification, :success, provider_id)

        {:ok, response}

      {:error, reason} ->
        Logger.error("Failed to send SMS to #{to}: #{inspect(reason)}")

        # Update the notification record with failure status
        error_message = extract_error_message(reason)
        update_notification(notification, :error, error_message)

        # If this was the final retry, just mark as permanently failed
        if job.attempt >= job.max_attempts do
          {:ok, %{error: error_message, status: "permanently_failed"}}
        else
          {:error, reason}
        end
    end
  end

  # Private helpers

  @doc false
  defp parse_scheduled_at(nil), do: nil

  defp parse_scheduled_at(scheduled_at) when is_binary(scheduled_at) do
    case DateTime.from_iso8601(scheduled_at) do
      {:ok, datetime, _} -> datetime
      _ -> nil
    end
  end

  @doc false
  defp extract_error_message(reason) do
    case reason do
      reason when is_binary(reason) ->
        reason

      reason when is_map(reason) ->
        reason["message"] || inspect(reason)

      _ ->
        inspect(reason)
    end
  end

  defp get_adapter_module do
    app = Application.get_application(__MODULE__) || :heckler
    config = Application.get_env(app, Heckler) || []
    config[:sms_adapter]
  end

  @doc false
  defp handle_notification_record(changeset) do
    # Only attempt to insert if we have Ecto and a Repo
    if Code.ensure_loaded?(Ecto) do
      # Try to get the app's repo
      app = Application.get_application(Heckler) || :heckler
      repo_mod = Application.get_env(app, :repo) || Application.get_env(:heckler, :repo)

      if repo_mod do
        case repo_mod.insert(changeset) do
          {:ok, notification} -> notification
          {:error, _} -> nil
        end
      else
        nil
      end
    else
      nil
    end
  end

  @doc false
  defp update_notification(nil, _, _), do: nil

  defp update_notification(notification, :success, provider_id) do
    if Code.ensure_loaded?(Ecto) do
      # Try to get the app's repo
      app = Application.get_application(Heckler) || :heckler
      repo_mod = Application.get_env(app, :repo) || Application.get_env(:heckler, :repo)

      if repo_mod do
        notification
        |> Notification.mark_sent(provider_id)
        |> repo_mod.update()
      end
    end
  end

  @doc false
  defp update_notification(notification, :error, error_message) do
    if Code.ensure_loaded?(Ecto) do
      # Try to get the app's repo
      app = Application.get_application(Heckler) || :heckler
      repo_mod = Application.get_env(app, :repo) || Application.get_env(:heckler, :repo)

      if repo_mod do
        notification
        |> Notification.mark_failed(error_message)
        |> repo_mod.update()
      end
    end
  end
end
