defmodule Exercism.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exercism,
      version: "0.1.0",
      deps_path: "./deps",
      lockfile: "./mix.lock",
      elixir: "~> 1.5.1",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end
end
