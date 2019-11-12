defmodule Nexmo.Account do
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  def get_balance() do
    params = %{
      api_key: Nexmo.Config.api_key,
      api_secret: Nexmo.Config.api_secret
    }
    Nexmo.Account.get("#{System.get_env("ACCOUNT_API_ENDPOINT")}/get-balance", [], params: params)
  end

  def top_up(trx) do
    params = [
      api_key: Nexmo.Config.api_key,
      api_secret: Nexmo.Config.api_secret
    ]
    body = Poison.encode!(%{trx: trx})
    Nexmo.Account.post("#{System.get_env("ACCOUNT_API_ENDPOINT")}/top-up", body, [], params: params)
  end

  def update(request) do
    params = [
      api_key: Nexmo.Config.api_key,
      api_secret: Nexmo.Config.api_secret
    ]
    body = Enum.into(request, %{})
    Nexmo.Account.post("#{System.get_env("ACCOUNT_API_ENDPOINT")}/settings", Poison.encode!(body), [], params: params)
  end

  def list_secrets() do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.get("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets", headers)  
  end

  def create_secret(request) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [
      {"Content-Type", "Config/json"},
      {"Authorization", "Basic #{credentials}"}
    ]
    body = Enum.into(request, %{})
    Nexmo.Account.post("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets", Poison.encode!(body), headers)
  end

  def get_secret(secret_id) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.get("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets/#{secret_id}", headers)  
  end

  def delete_secret(secret_id) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.delete("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets/#{secret_id}", headers)
  end
end