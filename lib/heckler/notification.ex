defmodule Heckler.Notification do
  @moduledoc """
  Schema for tracking and auditing notifications in the database.

  The `Heckler.Notification` schema represents a notification record in the database,
  storing all the details about messages sent through Heckler. This allows for:

  * Complete tracking of all sent notifications
  * Delivery status auditing
  * Detailed analytics on messaging patterns
  * Historical record of notification content

  ## Schema Fields

  * `:id` - Primary key
  * `:type` - Type of notification (e.g., "sms", "push")
  * `:status` - Current status ("pending", "sent", "failed")
  * `:to` - Recipient identifier (phone number for SMS, device token for push)
  * `:from` - Sender identifier (if applicable)
  * `:content` - The notification content
  * `:provider` - Service provider used (e.g., "twilio", "apns")
  * `:provider_message_id` - ID returned by the provider
  * `:scheduled_at` - When the notification was scheduled for delivery
  * `:sent_at` - When the notification was actually sent
  * `:error_message` - Error message if delivery failed
  * `:metadata` - Additional data related to the notification
  * Standard timestamps - `inserted_at` and `updated_at`

  ## Database Setup

  To set up the notifications table in your database, run:

  ```bash
  mix heckler.gen.migrations
  mix ecto.migrate
  ```

  ## Usage

  Notifications are typically created and managed internally by Heckler's workers.
  However, you can query the table directly for auditing or analytics:

  ```elixir
  # Get all notifications sent to a specific recipient
  YourApp.Repo.all(
    from n in Heckler.Notification,
    where: n.to == "+15551234567",
    order_by: [desc: n.inserted_at]
  )

  # Count notifications by status
  YourApp.Repo.all(
    from n in Heckler.Notification,
    group_by: n.status,
    select: {n.status, count(n.id)}
  )
  ```
  """

  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  A notification record structure
  """
  @type t :: %__MODULE__{
          id: pos_integer() | nil,
          type: String.t() | nil,
          status: String.t() | nil,
          to: String.t() | nil,
          from: String.t() | nil,
          content: String.t() | nil,
          provider: String.t() | nil,
          provider_message_id: String.t() | nil,
          scheduled_at: DateTime.t() | nil,
          sent_at: DateTime.t() | nil,
          error_message: String.t() | nil,
          metadata: map() | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil
        }

  @primary_key {:id, :id, autogenerate: true}
  schema "heckler_notifications" do
    field(:type, :string)
    field(:status, :string, default: "pending")
    field(:to, :string)
    field(:from, :string)
    field(:content, :string)
    field(:provider, :string)
    field(:provider_message_id, :string)
    field(:scheduled_at, :utc_datetime)
    field(:sent_at, :utc_datetime)
    field(:error_message, :string)
    field(:metadata, :map, default: %{})

    timestamps()
  end

  @required_fields ~w(type to content provider)a
  @optional_fields ~w(status from provider_message_id scheduled_at sent_at error_message metadata)a

  @doc """
  Creates a changeset for a new notification.

  This function validates the notification data and prepares it for
  insertion into the database.

  ## Parameters
    - `notification`: The existing notification struct (or a new one if not provided)
    - `attrs`: Attributes to set on the notification
    
  ## Returns
    - A changeset for the notification
    
  ## Example

  ```elixir
  changeset = Heckler.Notification.changeset(%{
    type: "sms",
    to: "+15551234567",
    content: "Hello world",
    provider: "twilio"
  })

  # Check if the changeset is valid
  if changeset.valid? do
    YourApp.Repo.insert(changeset)
  end
  ```
  """
  def changeset(notification \\ %__MODULE__{}, attrs) do
    notification
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  @doc """
  Creates a changeset for a new SMS notification.

  This is a convenience function for creating an SMS notification record
  with proper defaults already set.

  ## Parameters
    - `to`: The phone number to send the SMS to (E.164 format)
    - `content`: The SMS message content
    - `attrs`: Additional attributes for the notification

  ## Options in attrs
    - `:from`: Sender phone number
    - `:scheduled_at`: When the message is scheduled to be sent
    - `:metadata`: Additional data to store with the notification

  ## Returns
    - A changeset for the notification
    
  ## Example

  ```elixir
  # Create a basic SMS notification changeset
  changeset = Heckler.Notification.new_sms(
    "+15551234567",
    "Your verification code is 123456"
  )

  # Create an SMS notification with additional information
  changeset = Heckler.Notification.new_sms(
    "+15551234567",
    "Your order has shipped!",
    %{
      from: "+18005551234",
      scheduled_at: ~U[2023-12-25 10:00:00Z],
      metadata: %{
        order_id: "ORD-12345",
        tracking_number: "TRK-98765"
      }
    }
  )

  # Insert the notification record
  {:ok, notification} = YourApp.Repo.insert(changeset)
  ```
  """
  def new_sms(to, content, attrs \\ %{}) do
    attrs =
      Map.merge(attrs, %{
        type: "sms",
        to: to,
        content: content,
        provider: "twilio"
      })

    %__MODULE__{}
    |> changeset(attrs)
  end

  @doc """
  Updates a notification's status to "sent".

  This function should be called when a notification has been successfully delivered.
  It updates the status to "sent", records the timestamp, and saves the provider's
  message identifier for reference.

  ## Parameters
    - `notification`: The notification to mark as sent
    - `provider_message_id`: The message ID returned by the provider
    
  ## Returns
    - A changeset with the updated notification
    
  ## Example

  ```elixir
  # Assuming you have a notification record and a delivery confirmation
  notification = YourApp.Repo.get(Heckler.Notification, 123)
  provider_message_id = "SM123456789"

  # Mark as sent and update in the database
  {:ok, updated} = 
    notification
    |> Heckler.Notification.mark_sent(provider_message_id)
    |> YourApp.Repo.update()
  ```
  """
  def mark_sent(notification, provider_message_id) do
    notification
    |> changeset(%{
      status: "sent",
      sent_at: DateTime.utc_now(),
      provider_message_id: provider_message_id
    })
  end

  @doc """
  Updates a notification's status to "failed".

  This function should be called when a notification delivery has failed.
  It updates the status to "failed" and records the error message for troubleshooting.

  ## Parameters
    - `notification`: The notification to mark as failed
    - `error_message`: The error message from the delivery attempt
    
  ## Returns
    - A changeset with the updated notification
    
  ## Example

  ```elixir
  # Assuming you have a notification and an error occurred
  notification = YourApp.Repo.get(Heckler.Notification, 123)
  error_message = "Invalid phone number format"

  # Mark as failed and update in the database
  {:ok, updated} = 
    notification
    |> Heckler.Notification.mark_failed(error_message)
    |> YourApp.Repo.update()
  ```
  """
  def mark_failed(notification, error_message) do
    notification
    |> changeset(%{
      status: "failed",
      error_message: error_message
    })
  end
end
