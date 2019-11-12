defmodule Nexmo.MixProject do
  use Mix.Project

  def project do
    [
      app: :nexmo,
      version: "0.3.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      homepage_url: "https://developer.nexmo.com",
      source_url: "https://github.com/nexmo-community/nexmo-elixir"
    ]
  end

  defp description() do
    "Nexmo Client Library for Elixir"
  end

  defp package() do
    [
      name: "nexmo_elixir",
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGES* changelog* src),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nexmo-community/nexmo-elixir"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nexmo.Config, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0"},
      {:exjsx, "~> 4.0"},
      {:envy, "~> 1.1"},
      {:bypass, "~> 1.0", only: :test},
      {:mock, "~> 0.3.0", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
