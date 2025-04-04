#!/usr/bin/env elixir

# Add the project to the code path so we can use it as a library
Code.prepend_path("_build/dev/lib/heckler/ebin")

# Required dependencies
Code.prepend_path("_build/dev/lib/jason/ebin")
Code.prepend_path("_build/dev/lib/httpoison/ebin")
Code.prepend_path("_build/dev/lib/hackney/ebin")
Code.prepend_path("_build/dev/lib/oban/ebin")
Code.prepend_path("_build/dev/lib/ecto/ebin")
Code.prepend_path("_build/dev/lib/ecto_sql/ebin")
Code.prepend_path("_build/dev/lib/ecto_sqlite3/ebin")
Code.prepend_path("_build/dev/lib/telemetry/ebin")

defmodule ScheduleSMSScript do
  @moduledoc """
  A simple script to test Heckler's scheduled SMS functionality.
  
  Usage:
  $ elixir dev/schedule_sms.exs "+12345678900" "Your test message" 10
  
  The third parameter is the number of minutes in the future to schedule the message.
  If omitted, the message will be sent immediately.
  
  Note: You need to compile the project first with `mix compile`
  """

  def main(args) do
    # Parse command line arguments
    {to_number, message, minutes} = parse_args(args)
    
    # Start the application
    Application.ensure_all_started(:heckler)
    
    if minutes > 0 do
      # Schedule the message
      scheduled_time = DateTime.utc_now() |> DateTime.add(minutes * 60, :second)
      
      IO.puts("Scheduling SMS to #{to_number} with message: #{message}")
      IO.puts("Scheduled for: #{scheduled_time} (#{minutes} minutes from now)")
      
      case Heckler.Scheduler.schedule_sms(to_number, message, scheduled_time) do
        {:ok, job} ->
          IO.puts("✅ Message scheduled successfully!")
          IO.puts("Job ID: #{job.id}")
          IO.puts("Scheduled at: #{job.scheduled_at}")
        
        {:error, error} ->
          IO.puts("❌ Failed to schedule message")
          IO.inspect(error, label: "Error")
      end
    else
      # Send the message immediately
      IO.puts("Sending SMS immediately to #{to_number} with message: #{message}")
      
      case Heckler.Scheduler.send_sms_now(to_number, message) do
        {:ok, response} ->
          IO.puts("✅ Message sent successfully!")
          IO.inspect(response, label: "Response")
        
        {:error, error} ->
          IO.puts("❌ Failed to send message")
          IO.inspect(error, label: "Error")
      end
    end
    
    # Wait a moment for Oban to process the job if immediate
    if minutes == 0 do
      :timer.sleep(2000)
    end
  end
  
  defp parse_args(args) do
    case args do
      [to_number, message, minutes] -> 
        {to_number, message, String.to_integer(minutes)}
      
      [to_number, message] -> 
        {to_number, message, 0}  # Default to immediate delivery
      
      _ -> 
        IO.puts("Usage: elixir dev/schedule_sms.exs \"+12345678900\" \"Your test message\" [minutes]")
        System.halt(1)
    end
  end
end

# Run the script
ScheduleSMSScript.main(System.argv())