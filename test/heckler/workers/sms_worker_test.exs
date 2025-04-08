defmodule Heckler.Workers.SMSWorkerTest do
  use ExUnit.Case, async: true
  import Mox

  # Only run these tests if Oban is available
  setup do
    if Code.ensure_loaded?(Oban) do
      # Make sure mocks are verified when the test exits
      :ok = verify_on_exit!()
      :ok
    else
      :skip
    end
  end

  describe "perform/1" do
    setup do
      # Skip if Oban is not available
      if !Code.ensure_loaded?(Oban) do
        IO.puts("Skipping test because Oban is not available")
        exit(:skip)
      end

      # Create job with SMSMock as the adapter (as atom)
      job = %Oban.Job{
        id: 123,
        args: %{
          "to" => "+15551234567",
          "message" => "Test message from worker",
          "adapter" => SMSMock
        },
        attempt: 1,
        max_attempts: 3
      }

      %{job: job}
    end

    test "successfully sends SMS with specified adapter", %{job: job} do
      # Set up expectations for the SMSMock
      SMSMock
      |> expect(:send_sms, fn "+15551234567", "Test message from worker" ->
        {:ok, %{"sid" => "mock_worker_sid"}}
      end)

      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(job)

      # Check result
      assert {:ok, response} = result
      assert response["sid"] == "mock_worker_sid"
    end

    test "returns error when adapter fails", %{job: job} do
      # Set up mock to return an error
      SMSMock
      |> expect(:send_sms, fn _to, _message ->
        {:error, "Worker test failure"}
      end)

      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(job)

      # Since this is the first attempt, it should return an error to trigger retry
      assert {:error, "Worker test failure"} = result
    end

    test "gives up after max attempts", %{job: job} do
      # Set job to last attempt
      last_attempt_job = %{job | attempt: 3}

      # Set up mock to return an error
      SMSMock
      |> expect(:send_sms, fn _to, _message ->
        {:error, "Worker test failure"}
      end)

      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(last_attempt_job)

      # After max attempts, it should return OK to avoid further retries
      assert {:ok, %{error: error, status: "permanently_failed"}} = result
      assert error =~ "Worker test failure"
    end

    test "uses default adapter when none is specified", %{job: job} do
      # Remove adapter from args
      no_adapter_job = %{job | args: Map.delete(job.args, "adapter")}

      # Set up expectations for the default adapter (SMSMock)
      expect(SMSMock, :send_sms, fn "+15551234567", "Test message from worker" ->
        {:ok, %{"sid" => "default_mock_sid"}}
      end)

      # Perform the job
      result = Heckler.Workers.SMSWorker.perform(no_adapter_job)

      # Check result
      assert {:ok, response} = result
      assert response["sid"] == "default_mock_sid"
    end
  end
end
