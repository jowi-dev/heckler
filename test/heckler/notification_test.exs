defmodule Heckler.NotificationTest do
  use ExUnit.Case, async: true

  alias Heckler.Notification

  describe "changeset/2" do
    test "validates required fields" do
      # Create empty changeset
      changeset = Notification.changeset(%Notification{}, %{})

      # Should fail with multiple errors
      refute changeset.valid?

      # Check for required fields
      errors = Keyword.keys(changeset.errors)
      assert :type in errors
      assert :to in errors
      assert :content in errors
      assert :provider in errors
    end

    test "creates a valid changeset with all required fields" do
      attrs = %{
        type: "sms",
        to: "+15551234567",
        content: "Test notification content",
        provider: "test_provider"
      }

      changeset = Notification.changeset(%Notification{}, attrs)
      assert changeset.valid?
    end

    test "accepts optional fields" do
      attrs = %{
        type: "sms",
        to: "+15551234567",
        content: "Test notification content",
        provider: "test_provider",
        from: "+17775553333",
        status: "pending",
        scheduled_at: DateTime.utc_now(),
        metadata: %{test_key: "test_value"}
      }

      changeset = Notification.changeset(%Notification{}, attrs)
      assert changeset.valid?

      # Check that optional fields were included
      changes = changeset.changes
      assert changes.from == "+17775553333"
      assert changes.status == "pending"
      assert Map.has_key?(changes, :scheduled_at)
      assert changes.metadata == %{test_key: "test_value"}
    end
  end

  describe "new_sms/3" do
    test "creates an sms notification changeset" do
      to = "+15551234567"
      content = "Test SMS message"

      changeset = Notification.new_sms(to, content)

      # Verify it's valid
      assert changeset.valid?

      # Verify required fields are set correctly
      changes = changeset.changes
      assert changes.type == "sms"
      assert changes.to == to
      assert changes.content == content
      assert changes.provider == "twilio"
    end

    test "applies additional attributes" do
      to = "+15551234567"
      content = "Test SMS message"

      attrs = %{
        from: "+17775553333",
        scheduled_at: ~U[2025-01-01 12:00:00Z],
        metadata: %{campaign_id: "test_campaign"}
      }

      changeset = Notification.new_sms(to, content, attrs)

      # Verify it's valid
      assert changeset.valid?

      # Verify required and additional fields are set correctly
      changes = changeset.changes
      assert changes.type == "sms"
      assert changes.to == to
      assert changes.content == content
      assert changes.provider == "twilio"
      assert changes.from == "+17775553333"
      assert changes.scheduled_at == ~U[2025-01-01 12:00:00Z]
      assert changes.metadata == %{campaign_id: "test_campaign"}
    end
  end

  describe "mark_sent/2" do
    test "updates notification status to sent" do
      # Create a notification
      notification = %Notification{
        type: "sms",
        to: "+15551234567",
        content: "Test notification",
        provider: "twilio",
        status: "pending"
      }

      provider_id = "test_msg_123"
      changeset = Notification.mark_sent(notification, provider_id)

      # Verify changes
      assert changeset.changes.status == "sent"
      assert changeset.changes.provider_message_id == provider_id
      assert Map.has_key?(changeset.changes, :sent_at)
    end
  end

  describe "mark_failed/2" do
    test "updates notification status to failed" do
      # Create a notification
      notification = %Notification{
        type: "sms",
        to: "+15551234567",
        content: "Test notification",
        provider: "twilio",
        status: "pending"
      }

      error_message = "Test error message"
      changeset = Notification.mark_failed(notification, error_message)

      # Verify changes
      assert changeset.changes.status == "failed"
      assert changeset.changes.error_message == error_message
    end
  end
end
