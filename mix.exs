defmodule Heckler.MixProject do
  use Mix.Project

  def project do
    [
      app: :heckler,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "dev"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Heckler.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Core dependencies
      {:jason, "~> 1.1"},
      {:telemetry, "~> 0.4 or ~> 1.0"},
      
      # HTTP clients
      {:req, "~> 0.5.8"},
      {:tesla, "~> 1.7", optional: true},
      {:httpoison, "~> 2.0"},
      
      # Optional runtime dependencies (marked as optional)
      {:pigeon, "~> 2.0", optional: true},
      {:oban, "~> 2.18", optional: true},
      {:ecto_sql, "~> 3.10", optional: true},
      {:ecto_sqlite3, "~> 0.9", optional: true},
      {:myxql, "~> 0.7", optional: true},
      {:postgrex, "~> 0.16", optional: true},
      {:igniter, "~> 0.5", optional: true},
      
      # Development and test dependencies
      {:stream_data, "~> 1.0", only: [:test, :dev]},
      {:tz, "~> 0.24", only: [:test, :dev]},
      {:benchee, "~> 1.0", only: [:test, :dev], runtime: false},
      {:credo, "~> 1.7.7-rc.0", only: [:test, :dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:test, :dev], runtime: false},
      {:ex_doc, "~> 0.28", only: [:test, :dev], runtime: false},
      {:makeup_diff, "~> 0.1", only: [:test, :dev], runtime: false}
    ]
  end

  defp aliases do
    [
      # Development aliases
      "dev.setup": ["deps.get", "ecto.setup"],
      "dev.reset": ["deps.get", "ecto.reset"],
      
      # Test aliases
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      
      # Ecto aliases for dev testing
      "ecto.setup": ["ecto.create", "ecto.migrate", "run dev/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
