defmodule Heckler.Notification do
  @moduledoc """
  Schema representing a notification in the database.
  
  This schema is used to store all notifications sent through Heckler,
  allowing for easy tracking and auditing of messages.
  """
  
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  
  @type t :: %__MODULE__{}
  
  @primary_key {:id, :id, autogenerate: true}
  schema "heckler_notifications" do
    field :type, :string
    field :status, :string, default: "pending"
    field :to, :string
    field :from, :string
    field :content, :string
    field :provider, :string
    field :provider_message_id, :string
    field :scheduled_at, :utc_datetime
    field :sent_at, :utc_datetime
    field :error_message, :string
    field :metadata, :map, default: %{}
    
    timestamps()
  end
  
  @required_fields ~w(type to content provider)a
  @optional_fields ~w(status from provider_message_id scheduled_at sent_at error_message metadata)a
  
  @doc """
  Creates a changeset for a new notification.
  """
  def changeset(notification \\ %__MODULE__{}, attrs) do
    notification
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
  
  @doc """
  Creates a new SMS notification record.
  
  ## Parameters
    - to: The phone number to send the SMS to
    - content: The SMS content
    - attrs: Additional attributes for the notification
  
  ## Returns
    - `{:ok, notification}` if successful
    - `{:error, changeset}` if validation fails
  """
  def new_sms(to, content, attrs \\ %{}) do
    attrs = Map.merge(attrs, %{
      type: "sms",
      to: to,
      content: content,
      provider: "twilio"
    })
    
    %__MODULE__{}
    |> changeset(attrs)
  end
  
  @doc """
  Marks a notification as sent.
  
  ## Parameters
    - notification: The notification to mark as sent
    - provider_message_id: The message ID returned by the provider
    
  ## Returns
    - Updated notification changeset
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
  Marks a notification as failed.
  
  ## Parameters
    - notification: The notification to mark as failed
    - error_message: The error message
    
  ## Returns
    - Updated notification changeset
  """
  def mark_failed(notification, error_message) do
    notification
    |> changeset(%{
      status: "failed",
      error_message: error_message
    })
  end
end