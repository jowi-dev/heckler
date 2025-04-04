defmodule <%= @app_module %>.Repo.Migrations.AddHecklerNotifications do
  use Ecto.Migration

  def up do
    create table(:heckler_notifications) do
      add :type, :string, null: false
      add :status, :string, null: false, default: "pending"
      add :to, :string, null: false
      add :from, :string
      add :content, :text, null: false
      add :provider, :string, null: false
      add :provider_message_id, :string
      add :scheduled_at, :utc_datetime
      add :sent_at, :utc_datetime
      add :error_message, :text
      add :metadata, :map, default: %{}

      timestamps()
    end

    create index(:heckler_notifications, [:type])
    create index(:heckler_notifications, [:status])
    create index(:heckler_notifications, [:to])
    create index(:heckler_notifications, [:scheduled_at])
    create index(:heckler_notifications, [:provider])
    create index(:heckler_notifications, [:provider_message_id])
  end

  def down do
    drop table(:heckler_notifications)
  end
end