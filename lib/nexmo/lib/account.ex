defmodule Nexmo.Account do
  def get_balance() do
    params = %{
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret
    }
    Nexmo.Application.request(:get, "#{System.get_env("ACCOUNT_API_ENDPOINT")}/get-balance", params)
  end

  def top_up(trx) do
    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Accept", "text/html"}
    ]
    params = %{
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret,
    }
    body = %{
      trx: trx
    }
    encoded_body = URI.encode_query(body)
    Nexmo.Application.request(:post, "#{System.get_env("ACCOUNT_API_ENDPOINT")}/top-up", encoded_body, headers, params)
  end
end