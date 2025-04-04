# Heckler Project Notes

## Project Overview
Heckler is a notifications library for Elixir applications that makes it easier to send SMS and push notifications. It includes integrations with:
- Twilio for SMS messaging (implemented)
- APNS for Apple Push Notifications (partially implemented)
- Scheduling capabilities using Oban (in progress)

## Common Commands

### Testing Twilio SMS Integration
```shell
# Send a test SMS with Twilio
mix run textme.exs "+15023206035" "Hello world"

# Send a scheduled SMS in 5 minutes from now
mix run "dev/schedule_sms.exs" "+15023206035" "Scheduled test" 5
```

### Environment Variables Needed
- TWILIO_ACCOUNT_SID
- TWILIO_AUTH_TOKEN
- TWILIO_FROM_NUMBER
- TWILIO_MESSAGE_SERVICE_SID

## Project Structure
- `lib/heckler.ex`: Main supervisor
- `lib/heckler/sms.ex`: SMS behavior definition
- `lib/heckler/adapters/twilio.ex`: Twilio adapter for SMS
- `lib/heckler/scheduler.ex`: Notification scheduling with Oban
- `lib/heckler/workers/sms_worker.ex`: Oban worker for scheduled SMS
- `lib/heckler/notification.ex`: Ecto schema for tracking notifications

## Integration Strategy
1. Host applications include Heckler as a dependency
2. They run `mix heckler.gen.migrations` to create notification tables
3. Configure Twilio credentials in their application
4. Add Heckler to their supervision tree
5. Use Heckler's API to send and schedule notifications

## Testing Notes
For testing purposes, we set up PostgreSQL with Oban for development, enabling true scheduled notifications. The host application should also use Postgres for proper Oban integration.