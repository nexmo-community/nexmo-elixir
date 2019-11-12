defmodule Nexmo.Config do
  @moduledoc false
  use Application

  def start(_type, _args) do
    unless Mix.env == :prod do
      Envy.auto_load
    end
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Nexmo.Worker.start_link(arg)
      # {Nexmo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nexmo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def api_key do
    Application.get_env(:nexmo, :api_key) ||
      System.get_env("NEXMO_API_KEY")
  end

  def api_secret do
    Application.get_env(:nexmo, :api_secret) ||
      System.get_env("NEXMO_API_SECRET")
  end

  def merge_credentials(params) do
    params = convert_to_map(params)
    Map.merge(params, %{
      api_key: Nexmo.Config.api_key,
      api_secret: Nexmo.Config.api_secret
    })
  end

  def convert_to_map(params) do
    for {key, val} <- params, into: %{} do
      cond do
        is_atom(key) -> {key, val}
        true -> {String.to_atom(key), val}
      end
    end
  end
end
