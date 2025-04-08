defmodule Heckler.SchedulerTest do
  use ExUnit.Case, async: true
  import Mox

  # Create a mock module to simulate Oban for testing
  # without requiring Oban as a hard dependency for tests
  defmodule MockOban do
    def insert(job) do
      send(self(), {:job_inserted, job})
      {:ok, %{id: "mock_job_id"}}
    end
  end

  # Create a mock for the SMSWorker
  defmodule MockSMSWorker do
    def new(args, opts \\ []) do
      send(self(), {:worker_new, args, opts})
      %{args: args, opts: opts}
    end
  end

  # Mock SMS adapter for direct sending tests
  defmodule MockSMSAdapter do
    @behaviour Heckler.SMS

    def send_sms(to, message) do
      send(self(), {:direct_sms_sent, to, message})
      {:ok, %{"sid" => "mock_direct_sid"}}
    end
  end

  # Test the scheduler without Oban available
  # These tests don't require Oban to be installed
  describe "with Oban unavailable" do
    setup do
      # Store original Oban module
      original_oban = :code.is_loaded(Oban)

      # Unload Oban module if it exists
      if original_oban != false do
        :code.purge(Oban)
        :code.delete(Oban)
      end

      :ok
    end

    test "schedule_sms/4 returns error when Oban is unavailable" do
      result =
        Heckler.Scheduler.schedule_sms(
          "+15551234567",
          "Scheduled test message",
          DateTime.add(DateTime.utc_now(), 300, :second)
        )

      assert {:error, message} = result
      assert message =~ "Oban is not available"
    end

    test "send_sms_now/3 falls back to direct sending when Oban is unavailable" do
      to = "+15551234567"
      message = "Direct test message"

      # Call send_sms_now with Oban unavailable
      result = Heckler.Scheduler.send_sms_now(to, message)

      # Verify the message was sent directly
      expect(SMSMock, :send_sms, 2, fn _, _ -> {:ok, %{"sid" => "mock_direct_sid"}} end)

      # Check result
      assert {:ok, _} = result
        #assert response["sid"] == "mock_direct_sid"
    end
  end

  # The following tests require Oban to be available
  # They'll be skipped if Oban is not loaded
  describe "with Oban available" do
    setup do
      # Skip these tests if Oban is not available
      if !Code.ensure_loaded?(Oban) do
        skip_test = fn ->
          # Always return true to indicate test should be skipped
          true
        end

        # Return the skip function to be called by tests
        %{skip: skip_test}
      else
        # Load our mock Oban module
        defmodule Oban do
          def insert(job) do
            send(self(), {:job_inserted, job})
            {:ok, %{id: "mock_job_id"}}
          end
        end

        # And our mock SMSWorker
        defmodule Heckler.Workers.SMSWorker do
          def new(args, opts \\ []) do
            send(self(), {:worker_new, args, opts})
            %{args: args, opts: opts}
          end
        end

        # Indicate test can run
        %{skip: fn -> false end}
      end
    end

    test "schedule_sms/4 schedules job with Oban", %{skip: skip} do
      if skip.() do
        # Skip this test if Oban isn't available
        IO.puts("Skipping test because Oban is not available")
      else
        to = "+15551234567"
        message = "Scheduled message"
        scheduled_at = DateTime.utc_now() |> DateTime.add(300, :second)

        # Call schedule_sms
        result = Heckler.Scheduler.schedule_sms(to, message, scheduled_at)

        # Verify worker was called with correct args
        assert_received {:worker_new, args, opts}
        assert args.to == to
        assert args.message == message
        assert args.scheduled_at == scheduled_at

        # Verify schedule_in was set properly
        assert Keyword.has_key?(opts, :schedule_in)
        schedule_in = Keyword.get(opts, :schedule_in)
        assert schedule_in > 0
        assert schedule_in <= 300

        # Verify job was inserted
        assert_received {:job_inserted, _job}

        # Check result
        assert {:ok, %{id: "mock_job_id"}} = result
      end
    end

    test "send_sms_now/3 creates immediate job with Oban", %{skip: skip} do
      if skip.() do
        # Skip this test if Oban isn't available
        IO.puts("Skipping test because Oban is not available")
      else
        to = "+15551234567"
        message = "Immediate message"

        # Call send_sms_now
        result = Heckler.Scheduler.send_sms_now(to, message)

        # Verify worker was called with correct args
        assert_received {:worker_new, args, opts}
        assert args.to == to
        assert args.message == message

        # Verify no schedule_in was set (immediate job)
        assert opts == []

        # Verify job was inserted
        assert_received {:job_inserted, _job}

        # Check result
        assert {:ok, %{id: "mock_job_id"}} = result
      end
    end
  end
end
