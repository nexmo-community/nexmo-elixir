defmodule Nexmo.Account do
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  def get_balance() do
    params = %{
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret
    }
    Nexmo.Account.get("#{System.get_env("ACCOUNT_API_ENDPOINT")}/get-balance", [], params: params)
  end

  def top_up(trx) do
    params = [
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret
    ]
    body = Poison.encode!(%{trx: trx})
    Nexmo.Account.post("#{System.get_env("ACCOUNT_API_ENDPOINT")}/top-up", body, [], params: params)
  end

  def update(request) do
    params = [
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret
    ]
    body = Enum.into(request, %{})
    Nexmo.Account.post("#{System.get_env("ACCOUNT_API_ENDPOINT")}/settings", Poison.encode!(body), [], params: params)
  end
end