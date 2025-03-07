#!/usr/bin/env elixir

# Add the project to the code path so we can use it as a library
Code.prepend_path("_build/dev/lib/heckler/ebin")

# Required dependencies
Code.prepend_path("_build/dev/lib/jason/ebin")
Code.prepend_path("_build/dev/lib/httpoison/ebin")
Code.prepend_path("_build/dev/lib/hackney/ebin")
Code.prepend_path("_build/dev/lib/certifi/ebin")
Code.prepend_path("_build/dev/lib/parse_trans/ebin")
Code.prepend_path("_build/dev/lib/metrics/ebin")
Code.prepend_path("_build/dev/lib/mimerl/ebin")
Code.prepend_path("_build/dev/lib/unicode_util_compat/ebin")
Code.prepend_path("_build/dev/lib/idna/ebin")

defmodule TextMeScript do
  @moduledoc """
  A simple script to test Heckler's Twilio SMS integration.
  
  Usage:
  $ elixir textme.exs "+12345678900" "Your test message"
  
  Note: You need to compile the project first with `mix compile`
  """

  def main(args) do
    # Get command line arguments
    {to_number, message} = parse_args(args)
    
    # Configure Twilio with environment variables
    Application.put_env(:heckler, Heckler.Adapters.Twilio, [
      account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
      auth_token: System.get_env("TWILIO_AUTH_TOKEN"),
      from_number: System.get_env("TWILIO_FROM_NUMBER"),
      message_service_sid: System.get_env("TWILIO_MESSAGE_SERVICE_SID")
    ])
    
    # Configure the adapter to use
    Application.put_env(:heckler, Heckler, [
      sms_adapter: Heckler.Adapters.Twilio
    ])
    
    # Send the message directly via the adapter
    IO.puts("Sending SMS to #{to_number} with message: #{message}")
    case Heckler.SMS.send(to_number, message) do
      {:ok, response} ->
        IO.puts("✅ Message sent successfully!")
        IO.puts("Message SID: #{response["sid"]}")
        IO.puts("Status: #{response["status"]}")
      
      {:error, error} ->
        IO.puts("❌ Failed to send message")
        IO.inspect(error, label: "Error")
    end
  end
  
  defp parse_args(args) do
    case args do
      [to_number, message] -> {to_number, message}
      _ -> 
        IO.puts("Usage: elixir textme.exs \"+12345678900\" \"Your test message\"")
        System.halt(1)
    end
  end
end

# Run the script
TextMeScript.main(System.argv())
