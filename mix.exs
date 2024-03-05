defmodule Dyndb.MixProject do
  use Mix.Project

  def project do
    [
      app: :dyndb,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Dyndb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, ">= 0.0.0"},
      {:ecto_sql, ">= 0.0.0"},
      {:ash, "~> 2.19.9"},
      {:ash_postgres, "~> 1.5.10"}
    ]
  end
end
