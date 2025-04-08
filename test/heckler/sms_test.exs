defmodule Heckler.SMSTest do
  use ExUnit.Case, async: true
  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "send/2" do
    test "successfully sends SMS using configured adapter" do
      # Set up expectations for the mock
      to = "+15551234567"
      message = "Test message"

      expect(SMSMock, :send_sms, fn ^to, ^message ->
        {:ok, %{"sid" => "mock_sid", "status" => "sent"}}
      end)

      # Send a test message
      result = Heckler.SMS.send(to, message)

      # Verify result
      assert {:ok, response} = result
      assert response["sid"] == "mock_sid"
      assert response["status"] == "sent"
    end

    test "returns error when no adapter is configured" do
      # Temporarily remove the mock adapter from config
      original_config = Application.get_env(:heckler, Heckler)
      Application.put_env(:heckler, Heckler, [])

      # Send a test message
      result = Heckler.SMS.send("+15551234567", "Test message")

      # Verify error result
      assert {:error, error_message} = result
      assert error_message =~ "No SMS adapter configured"

      # Restore original configuration
      Application.put_env(:heckler, Heckler, original_config)
    end

    test "forwards errors from the adapter" do
      # Set up mock to return an error

      expect(SMSMock, :send_sms, fn _to, _message ->
        {:error, "Simulated failure"}
      end)

      # Send a test message
      result = Heckler.SMS.send("+15551234567", "Test message")

      # Verify error is forwarded
      assert {:error, "Simulated failure"} = result
    end
  end
end
