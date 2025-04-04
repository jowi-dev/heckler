# This file contains seed data for development testing

alias Heckler.Notification
alias Heckler.DevRepo

# Create some sample notification records
now = DateTime.utc_now()
one_hour_ago = DateTime.add(now, -3600, :second)
two_hours_ago = DateTime.add(now, -7200, :second)

# Sample Twilio SMS records
sms_records = [
  %{
    type: "sms",
    status: "sent",
    to: "+15551234567",
    from: System.get_env("TWILIO_FROM_NUMBER"),
    content: "This is a test message #1",
    provider: "twilio",
    provider_message_id: "SM65a9a2377a560a0cd2a1c64ac2f8a401",
    sent_at: one_hour_ago,
    metadata: %{
      "status_callback" => "https://example.com/sms/callback"
    }
  },
  %{
    type: "sms",
    status: "failed",
    to: "+15551234568",
    from: System.get_env("TWILIO_FROM_NUMBER"),
    content: "This is a test message that failed",
    provider: "twilio",
    error_message: "Invalid phone number",
    sent_at: two_hours_ago,
    metadata: %{}
  },
  %{
    type: "sms",
    status: "pending",
    to: "+15551234569",
    from: System.get_env("TWILIO_FROM_NUMBER"),
    content: "This is a scheduled message",
    provider: "twilio",
    scheduled_at: DateTime.add(now, 3600, :second),
    metadata: %{
      "campaign_id" => "welcome_flow"
    }
  }
]

# Insert all records
for record <- sms_records do
  %Notification{}
  |> Notification.changeset(record)
  |> DevRepo.insert!()
end

IO.puts("Seed data inserted successfully!")