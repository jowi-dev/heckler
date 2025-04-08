defmodule Heckler.SchedulerTest do
  use ExUnit.Case, async: true
  import Mox

  # The following tests require Oban to be available
  # They'll be skipped if Oban is not loaded
  describe "with Oban available" do
    test "schedule_sms/4 schedules job with Oban" do
      to = "+15551234567"
      message = "Scheduled message"
      scheduled_at = DateTime.add(DateTime.utc_now(), 300, :second)

      expect(SMSMock, :send_sms, fn _, _ -> {:ok, true} end)

      # Call schedule_sms
      assert {:ok, %Oban.Job{args: args, scheduled_at: schedule}} =
               Heckler.Scheduler.schedule_sms(to, message, scheduled_at)

      # Verify worker was called with correct args
      assert args.to == to
      assert args.message == message
      assert schedule.year == scheduled_at.year
      assert schedule.month == scheduled_at.month
      assert schedule.day == scheduled_at.day
      assert schedule.hour == scheduled_at.hour
      assert schedule.minute == scheduled_at.minute
      assert schedule.second == scheduled_at.second
    end

    test "send_sms_now/3 creates immediate job with Oban" do
      to = "+15551234567"
      message = "Immediate message"

      # Call send_sms_now
      # nil scheduled at means immediately
      assert {:ok, %Oban.Job{args: args, scheduled_at: nil}} =
               Heckler.Scheduler.send_sms_now(to, message)

      # Verify worker was called with correct args
      assert args.to == to
      assert args.message == message
    end
  end
end
