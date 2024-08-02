defmodule Supermarket.MixProject do
  use Mix.Project

  def project do
    [
      app: :supermarket,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Supermarket.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:decimal, "~> 2.0"}
    ]
  end

  defp aliases do
    [
      "format.lint": ["format --check-formatted", "credo --strict"]
    ]
  end
end
