defmodule Mix.Tasks.Heckler.Dev.Setup do
  @moduledoc """
  Sets up the development environment for Heckler.

  This task prepares the local development database for testing Heckler.
  It runs the same migrations that would be used in a real application.

  ## Usage

      mix heckler.dev.setup

  This will:
  1. Create the SQLite database
  2. Run the migrations
  3. Seed the database with test data
  """
  
  use Mix.Task
  
  @shortdoc "Sets up development environment for Heckler"
  
  @impl Mix.Task
  def run(_args) do
    # Make sure we're in dev environment
    Mix.Task.run("app.config", ["--env", "dev"])
    
    # Start the application
    {:ok, _} = Application.ensure_all_started(:heckler)
    
    # Create the dev repo migrations directory if it doesn't exist
    dev_migrations_path = Path.join(["priv", "dev_repo", "migrations"])
    File.mkdir_p!(dev_migrations_path)
    
    # Copy the generated migrations to dev_repo/migrations
    copy_migrations("priv/repo/migrations", dev_migrations_path)
    
    # Run the migrations
    run_migrations()
    
    # Seed the database
    if File.exists?("dev/seeds.exs") do
      Mix.shell().info("Running seeds...")
      Code.eval_file("dev/seeds.exs")
    end
    
    Mix.shell().info("""
    
    Development environment setup complete!
    
    You can now test Heckler with:
    
    1. Send an immediate SMS:
       mix run "dev/schedule_sms.exs" "+15023206035" "Test message"
    
    2. Schedule an SMS for 5 minutes from now:
       mix run "dev/schedule_sms.exs" "+15023206035" "Scheduled test" 5
    """)
  end
  
  defp copy_migrations(source_dir, target_dir) do
    if File.exists?(source_dir) do
      source_dir
      |> File.ls!()
      |> Enum.filter(&String.ends_with?(&1, ".exs"))
      |> Enum.each(fn file ->
        source_path = Path.join(source_dir, file)
        # Extract timestamp and name
        [timestamp, name] = 
          file
          |> Path.rootname()
          |> String.split("_", parts: 2)
        
        # Use the same timestamp but rename the file
        target_file = "#{timestamp}_#{name}.exs"
        target_path = Path.join(target_dir, target_file)
        
        # Read the file and change the module name
        content = File.read!(source_path)
        updated_content = 
          content
          |> String.replace("Repo.Migrations", "DevRepo.Migrations")
        
        # Write the file
        File.write!(target_path, updated_content)
        Mix.shell().info([:green, "* copied migration ", :reset, target_path])
      end)
    end
  end
  
  defp run_migrations do
    Mix.shell().info("Running migrations...")
    
    # Get the migrations path
    migrations_path = Path.join(["priv", "dev_repo", "migrations"])
    
    if File.exists?(migrations_path) do
      # Run migrations using standard migrator approach
      Ecto.Migrator.with_repo(Heckler.DevRepo, fn repo ->
        Ecto.Migrator.run(repo, migrations_path, :up, all: true, log: :info)
      end)
      
      Mix.shell().info([:green, "* migrations complete"])
    else
      Mix.shell().error("No migrations found in #{migrations_path}")
    end
  end
end