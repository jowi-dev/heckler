defmodule Heckler.MixProject do
  use Mix.Project

  def project do
    [
      app: :heckler,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:pigeon, "~> 2.0"},
      {:oban, "~> 2.18"},
      {:ecto_sql, "~> 3.10"},
      {:ecto_sqlite3, "~> 0.9", optional: true},
      {:jason, "~> 1.1"},
      {:igniter, "~> 0.5", optional: true},
      {:myxql, "~> 0.7", optional: true},
      {:postgrex, "~> 0.16", optional: true},
      {:telemetry, "~> 0.4 or ~> 1.0"},
      {:stream_data, "~> 1.0", only: [:test, :dev]},
      {:tz, "~> 0.24", only: [:test, :dev]},
      {:benchee, "~> 1.0", only: [:test, :dev], runtime: false},
      {:credo, "~> 1.7.7-rc.0", only: [:test, :dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:test, :dev], runtime: false},
      {:ex_doc, "~> 0.28", only: [:test, :dev], runtime: false},
      {:makeup_diff, "~> 0.1", only: [:test, :dev], runtime: false},
      {:req, "~> 0.5.8"}
    ]
  end
end
