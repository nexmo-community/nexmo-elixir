defmodule Nexmo.Account do
  def get_balance() do
    params = %{
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret
    }
    Nexmo.Application.request(:get, "#{System.get_env("ACCOUNT_API_ENDPOINT")}/get-balance", params)
  end
end