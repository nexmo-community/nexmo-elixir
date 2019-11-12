defmodule Nexmo.Config do
    @moduledoc """
    The `Nexmo.Config` module provides configuration settings and helper functions to the application.
    """
    @moduledoc since: "0.1.0"
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

  @doc """
  Prints the Nexmo API key stored as an environment variable.

  ## Examples

      iex> Nexmo.Config.api_key
      "123456789"

  """
  @doc since: "0.1.0"
  def api_key do
    Application.get_env(:nexmo, :api_key) ||
      System.get_env("NEXMO_API_KEY")
  end

  @doc """
  Prints the Nexmo API secret stored as an environment variable.

  ## Examples

    iex> Nexmo.Config.api_secret
    "this_is_a_sample_secret"

  """
  @doc since: "0.1.0"
  def api_secret do
    Application.get_env(:nexmo, :api_secret) ||
      System.get_env("NEXMO_API_SECRET")
  end

  @doc """
  `Nexmo.Config.merge_credentials/1` takes the user inputted parameters and merges the user's 
  Nexmo API credentials into the map.

  ## Examples

      iex> Nexmo.Config.merge_credentials(%{a: '123', b: '456'})
      %{a: '123', b: '456', api_key: '123456789', api_secret: 'this_is_a_sample_secret'}

  """
  @doc since: "0.3.0"
  def merge_credentials(params) do
    params = convert_to_map(params)
    Map.merge(params, %{
      api_key: Nexmo.Config.api_key,
      api_secret: Nexmo.Config.api_secret
    })
  end

  @doc """
  `Nexmo.Config.convert_to_maap/1` takes the user inputted parameters and converts them into a map.

  ## Examples

      iex> Nexmo.Config.convert_to_map({a, '123'})
      %{a: '123'}

  """
  @doc since: "0.3.0"
  def convert_to_map(params) do
    for {key, val} <- params, into: %{} do
      cond do
        is_atom(key) -> {key, val}
        true -> {String.to_atom(key), val}
      end
    end
  end
end
