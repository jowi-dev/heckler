defmodule Heckler.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = 
      []
      |> add_repo_if_development()
      |> add_oban_if_configured()
      |> add_apns_if_configured()

    opts = [strategy: :one_for_one, name: Heckler.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Only add Repo in development mode, when we're running standalone
  defp add_repo_if_development(children) do
    if Mix.env() in [:dev, :test] do
      # Check if we're running as a standalone application (not as a dependency)
      app_name = Mix.Project.config()[:app]
      
      if app_name == :heckler do
        # We're in the Heckler project itself, use our dev Repo
        if Code.ensure_loaded?(Ecto) do
          children ++ [{Heckler.DevRepo, []}]
        else
          children
        end
      else
        # We're in a host application, don't add our Repo
        children
      end
    else
      children
    end
  end

  # Add Oban if configured
  defp add_oban_if_configured(children) do
    oban_config = Application.get_env(:heckler, Oban, [])
    
    if oban_config != [] && Code.ensure_loaded?(Oban) do
      children ++ [{Oban, oban_config}]
    else
      children
    end
  end

  # Add APNS service if configured
  defp add_apns_if_configured(children) do
    apns_opts = Application.get_env(:heckler, Heckler.APNS)
    
    if apns_opts && Code.ensure_loaded?(Pigeon.APNS) do
      children ++ [{Heckler.APNS, apns_opts}]
    else
      children
    end
  end
end

# Development-only repository for testing
if Mix.env() in [:dev, :test] do
  defmodule Heckler.DevRepo do
    @moduledoc false
    use Ecto.Repo, 
      otp_app: :heckler,
      adapter: Ecto.Adapters.Postgres
    
    def init(_type, config) do
      # Allow runtime configuration for local development
      {:ok, config}
    end
  end
end