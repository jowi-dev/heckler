defmodule Heckler.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/yourusername/heckler"
  @description "SMS and push notification library for Elixir applications"

  def project do
    [
      app: :heckler,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),

      # Hex.pm
      description: @description,
      package: package(),

      # Docs
      name: "Heckler",
      source_url: @source_url,
      homepage_url: @source_url,
      docs: docs(),

      # Test coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
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
      {:ex_doc, "~> 0.36.1", only: [:test, :dev], runtime: false},
      {:excoveralls, "~> 0.16", only: :test},
      {:makeup_diff, "~> 0.1", only: [:test, :dev], runtime: false},
      {:mox, "~> 1.2", only: [:test]}
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

  defp package do
    [
      maintainers: ["Your Name"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE)
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      # logo: "priv/static/heckler_logo.png",
      extras: [
        "README.md": [title: "Overview"],
        LICENSE: [title: "License"]
      ],
      groups_for_modules: [
        Core: [
          Heckler,
          Heckler.SMS,
          Heckler.Scheduler,
          Heckler.Notification
        ],
        Adapters: [
          Heckler.Adapters.Twilio
        ],
        Workers: [
          Heckler.Workers.SMSWorker
        ],
        "Apple Push Notifications": [
          Heckler.APNS
        ]
      ]
    ]
  end
end
