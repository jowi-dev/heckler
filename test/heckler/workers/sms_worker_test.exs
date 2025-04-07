defmodule Heckler.Workers.SMSWorkerTest do
  use ExUnit.Case, async: true

  # Only run these tests if Oban is available
  setup do
    if Code.ensure_loaded?(Oban) do
      :ok
    else
      :skip
    end
  end

  # Define a mock SMS adapter for testing worker behavior
  defmodule MockAdapter do
    @behaviour Heckler.SMS

    def send_sms(to, message) do
      send(self(), {:sms_worker_sent, to, message})
      {:ok, %{"sid" => "mock_worker_sid"}}
    end
  end

  # Mock failing adapter
  defmodule FailingAdapter do
    @behaviour Heckler.SMS

    def send_sms(_to, _message) do
      {:error, "Worker test failure"}
    end
  end

  describe "perform/1" do
    setup do
      # Skip if Oban is not available
      if !Code.ensure_loaded?(Oban) do
        IO.puts("Skipping test because Oban is not available")
        exit(:skip)
      end

      # Create mock job
      job = %Oban.Job{
        id: 123,
        args: %{
          "to" => "+15551234567",
          "message" => "Test message from worker",
          "adapter" => "Heckler.Workers.SMSWorkerTest.MockAdapter"
        },
        attempt: 1,
        max_attempts: 3
      }

      %{job: job}
    end

    test "successfully sends SMS with specified adapter", %{job: job} do
      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(job)

      # Verify the adapter was called correctly
      assert_received {:sms_worker_sent, "+15551234567", "Test message from worker"}

      # Check result
      assert {:ok, response} = result
      assert response["sid"] == "mock_worker_sid"
    end

    test "returns error when adapter fails", %{job: job} do
      # Create a job with failing adapter
      failing_job = %{
        job
        | args: Map.put(job.args, "adapter", "Heckler.Workers.SMSWorkerTest.FailingAdapter")
      }

      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(failing_job)

      # Since this is the first attempt, it should return an error to trigger retry
      assert {:error, "Worker test failure"} = result
    end

    test "gives up after max attempts", %{job: job} do
      # Create a job with failing adapter at max attempts
      last_attempt_job = %{
        job
        | args: Map.put(job.args, "adapter", "Heckler.Workers.SMSWorkerTest.FailingAdapter"),
          # last attempt
          attempt: 3
      }

      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(last_attempt_job)

      # After max attempts, it should return OK to avoid further retries
      assert {:ok, %{error: error, status: "permanently_failed"}} = result
      assert error =~ "Worker test failure"
    end

    test "uses default adapter when none is specified", %{job: job} do
      # Remove adapter from args
      no_adapter_job = %{job | args: Map.delete(job.args, "adapter")}

      # Override the default Twilio adapter temporarily
      original_module = Heckler.Adapters.Twilio

      try do
        # Redefine the module temporarily
        :code.purge(Heckler.Adapters.Twilio)
        :code.delete(Heckler.Adapters.Twilio)

        defmodule Heckler.Adapters.Twilio do
          @behaviour Heckler.SMS

          def send_sms(to, message) do
            send(self(), {:default_adapter_called, to, message})
            {:ok, %{"sid" => "default_mock_sid"}}
          end
        end

        # Perform the job
        result = Heckler.Workers.SMSWorker.perform(no_adapter_job)

        # Verify default adapter was called
        assert_received {:default_adapter_called, "+15551234567", "Test message from worker"}

        # Check result
        assert {:ok, response} = result
        assert response["sid"] == "default_mock_sid"
      after
        # Restore original module
        if original_module != nil do
          :code.purge(Heckler.Adapters.Twilio)
          :code.delete(Heckler.Adapters.Twilio)
        end
      end
    end
  end
end
