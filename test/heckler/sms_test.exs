defmodule Heckler.SMSTest do
  use ExUnit.Case, async: true

  # Define a mock SMS adapter for testing
  defmodule MockSMSAdapter do
    @behaviour Heckler.SMS

    def send_sms(to, message) do
      # Store the call for verification
      send(self(), {:sms_sent, to, message})

      # Return a successful response
      {:ok, %{"sid" => "mock_sid", "status" => "sent"}}
    end
  end

  # Define a failing SMS adapter for testing errors
  defmodule FailingSMSAdapter do
    @behaviour Heckler.SMS

    def send_sms(_to, _message) do
      {:error, "Simulated failure"}
    end
  end

  setup do
    # Store original adapter configuration to restore later
    original_config = Application.get_env(:heckler, Heckler.SMS)[:adapter]

    on_exit(fn ->
      # Restore original configuration after each test
      if is_nil(original_config) do
        Application.delete_env(:heckler, Heckler.SMS)
      else
        Application.put_env(:heckler, Heckler.SMS, adapter: original_config)
      end
    end)

    :ok
  end

  describe "send/2" do
    test "successfully sends SMS using configured adapter" do
      # Configure our test adapter
      Application.put_env(:heckler, Heckler.SMS, adapter: MockSMSAdapter)

      # Send a test message
      to = "+15551234567"
      message = "Test message"
      result = Heckler.SMS.send(to, message)

      # Verify result
      assert {:ok, response} = result
      assert response["sid"] == "mock_sid"
      assert response["status"] == "sent"

      # Verify adapter was called with correct params
      assert_received {:sms_sent, ^to, ^message}
    end

    test "returns error when no adapter is configured" do
      # Ensure no adapter is configured
      Application.delete_env(:heckler, Heckler.SMS)

      # Send a test message
      result = Heckler.SMS.send("+15551234567", "Test message")

      # Verify error result
      assert {:error, error_message} = result
      assert error_message =~ "No SMS adapter configured"
    end

    test "forwards errors from the adapter" do
      # Configure our failing adapter
      Application.put_env(:heckler, Heckler.SMS, adapter: FailingSMSAdapter)

      # Send a test message
      result = Heckler.SMS.send("+15551234567", "Test message")

      # Verify error is forwarded
      assert {:error, "Simulated failure"} = result
    end
  end
end
