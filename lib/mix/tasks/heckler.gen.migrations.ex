defmodule Mix.Tasks.Heckler.Gen.Migrations do
  @moduledoc """
  Generates database migrations for Heckler.

  ## Usage

      mix heckler.gen.migrations

  This will generate the necessary migrations for Heckler to store notification records.
  """

  use Mix.Task

  @shortdoc "Generates Heckler database migrations"

  @templates_path "priv/templates/heckler.gen.migrations"

  @impl Mix.Task
  def run(_args) do
    app_module = Mix.Project.config()[:app] |> to_string() |> Macro.camelize()
    timestamp = timestamp()

    # Create migrations directory if it doesn't exist
    migrations_path = Path.join(["priv", "repo", "migrations"])
    File.mkdir_p!(migrations_path)

    create_migration(
      "#{timestamp}_add_heckler_notifications.exs",
      "add_heckler_notifications_table.exs",
      app_module,
      migrations_path
    )

    Mix.shell().info("""

    Heckler migrations generated successfully!

    Next steps:

    1. Run the migrations with:
       mix ecto.migrate

    2. Configure Oban in your config.exs:
       
       config :your_app, Oban,
         repo: YourApp.Repo,
         plugins: [Oban.Plugins.Pruner],
         queues: [notifications: 10]

    3. Configure Heckler in your config.exs:
       
       config :your_app, Heckler,
         sms_adapter: Heckler.Adapters.Twilio

    4. Add Heckler to your application supervision tree:
       
       def start(_type, _args) do
         children = [
           # ... other children
           {Heckler, []}
         ]
         
         Supervisor.start_link(children, strategy: :one_for_one)
       end
    """)
  end

  defp create_migration(target_filename, source_template, app_module, migrations_path) do
    source_path = Path.join([@templates_path, source_template])
    target_path = Path.join(migrations_path, target_filename)

    assigns = [app_module: app_module]

    case File.read(source_path) do
      {:ok, template} ->
        content = EEx.eval_string(template, assigns: assigns)
        File.write!(target_path, content)
        Mix.shell().info([:green, "* created ", :reset, target_path])

      {:error, reason} ->
        Mix.raise("Failed to read template #{source_path}: #{inspect(reason)}")
    end
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: "0#{i}"
  defp pad(i), do: "#{i}"
end
