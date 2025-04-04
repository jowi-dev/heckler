defmodule Heckler.Workers.SMSWorker do
  @moduledoc """
  An Oban worker for sending SMS messages through Heckler.
  
  This worker handles both immediate and scheduled SMS notifications,
  and stores records of all sent notifications in the database.
  """
  
  use Oban.Worker, queue: :notifications, max_attempts: 3
  
  require Logger
  alias Heckler.Notification
  
  @impl Oban.Worker
  def perform(%Oban.Job{args: args} = job) do
    %{
      "to" => to,
      "message" => message
    } = args
    
    # Get the adapter module (default to Twilio)
    adapter_module = get_adapter_module(args)
    
    # Extract options 
    options = Map.get(args, "options", %{})
    scheduled_at = Map.get(args, "scheduled_at")
    
    # First, create a notification record
    notification_attrs = %{
      scheduled_at: scheduled_at && DateTime.from_iso8601(scheduled_at) |> elem(1),
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
        error_message = 
          case reason do
            reason when is_binary(reason) -> reason
            reason when is_map(reason) -> 
              reason["message"] || inspect(reason)
            _ -> inspect(reason)
          end
        
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
  
  defp get_adapter_module(args) do
    adapter = Map.get(args, "adapter", "Heckler.Adapters.Twilio")
    
    case adapter do
      adapter when is_binary(adapter) -> 
        # Check if the module exists before converting
        try do
          String.to_existing_atom(adapter)
        rescue
          ArgumentError -> Heckler.Adapters.Twilio
        end
      
      adapter when is_atom(adapter) -> adapter
      _ -> Heckler.Adapters.Twilio
    end
  end
  
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