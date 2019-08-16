defmodule Nexmo.MixProject do
  use Mix.Project

  def project do
    [
      app: :nexmo,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nexmo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:poison, "~> 4.0"},
      {:exjsx, "~> 4.0"},
      {:envy, "~> 1.1"},
      {:bypass, "~> 1.0", only: :test}
    ]
  end
end
