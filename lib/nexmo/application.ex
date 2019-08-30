defmodule Nexmo.Application do
  @moduledoc false

  use Application
  use HTTPoison.Base

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

  def process_response_body(body) do
    JSX.decode!(body)
  end

  def request(method, endpoint, body, headers) when method == :post and not is_nil(headers) do
    Nexmo.Application.post(endpoint, body, headers)
  end
  def request(method, endpoint, params, headers) when method == :get and not is_nil(headers) do
    Nexmo.Application.get(endpoint, headers, params)
  end
  def request(method, endpoint, body) when method == :post do
    Nexmo.Application.post(endpoint, JSX.encode!(body))
  end
  def request(method, endpoint, params) when method == :get do
    Nexmo.Application.get(endpoint, [], params: params)
  end

  def api_key do
    Application.get_env(:nexmo, :api_key) ||
      System.get_env("NEXMO_API_KEY")
  end

  def api_secret do
    Application.get_env(:nexmo, :api_secret) ||
      System.get_env("NEXMO_API_SECRET")
  end
end
