defmodule Nexmo.Account do
  @moduledoc """
  The `Nexmo.Account` module provides Nexmo Account API functionality.
  """
  @moduledoc since: "0.2.0"
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  @doc """
  Get your Nexmo account balance.

  ## Examples

      iex> Nexmo.Account.get_balance

  ## Documentation

  Docs: [https://developer.nexmo.com/api/account#getAccountBalance](https://developer.nexmo.com/api/account#getAccountBalance?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#get-account-balance)
  """
  @doc since: "0.2.0"
  def get_balance() do
    params = %{
      api_key: Nexmo.Config.api_key,
      api_secret: Nexmo.Config.api_secret
    }
    Nexmo.Account.get("#{System.get_env("ACCOUNT_API_ENDPOINT")}/get-balance", [], params: params)
  end

  @doc """
  Top up your Nexmo account balance.

  ## Examples

      iex> Nexmo.Account.top_up(trx: "transaction_reference")
  
  ## Documentation

  Docs: [https://developer.nexmo.com/api/account#topUpAccountBalance](https://developer.nexmo.com/api/account#topUpAccountBalance?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#topUp-account-balance)  
  """
  @doc since: "0.2.0"
  def top_up(params) do
    params = Nexmo.Config.merge_credentials(params)
    body = Poison.encode!(params)
    Nexmo.Account.post("#{System.get_env("ACCOUNT_API_ENDPOINT")}/top-up", body, [], params: params)
  end

  @doc """
  Change account settings.

  ## Examples

      iex> Nexmo.Account.update(
        moCallBackUrl: "https://example.com/inbound", 
        drCallBackUrl: "https://example.com/delivery"
      )

  ## Documentation

  Docs: [https://developer.nexmo.com/api/account#changeAccountSettings](https://developer.nexmo.com/api/account#changeAccountSettings?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#change-account-settings)
  """
  @doc since: "0.2.0"
  def update(params) do
    params = Nexmo.Config.merge_credentials(params)
    body = Enum.into(params, %{})
    Nexmo.Account.post("#{System.get_env("ACCOUNT_API_ENDPOINT")}/settings", Poison.encode!(body), [], params: params)
  end

  @doc """
  List all account secrets.

  ## Examples

      iex> Nexmo.Account.list_secrets()

  ## Documentation

  Docs: [https://developer.nexmo.com/api/account#retrieveAPISecrets](https://developer.nexmo.com/api/account#retrieveAPISecrets?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#retrieve-api-secrets)  
  """
  @doc since: "0.2.0"  
  def list_secrets() do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.get("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets", headers)  
  end

  @doc """
  Create a Nexmo account secret.

  ## Examples

      iex> Nexmo.Account.create_secret(secret: "example-4PI-Secret")

  ## Documentation

  Docs: [https://developer.nexmo.com/api/account#createAPISecret](https://developer.nexmo.com/api/account#createAPISecret?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#create-api-secret)
  """
  @doc since: "0.2.0"
  def create_secret(request) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [
      {"Content-Type", "Config/json"},
      {"Authorization", "Basic #{credentials}"}
    ]
    body = Enum.into(request, %{})
    Nexmo.Account.post("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets", Poison.encode!(body), headers)
  end

  @doc """
  Get one account secret.

  ## Examples

      iex> Nexmo.Account.get_secret(secret_id: "secret_id")

  ## Documentation
  
  Docs: [https://developer.nexmo.com/api/account#retrieveAPISecret](https://developer.nexmo.com/api/account#retrieveAPISecret?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#retrieve-api-secret)
  """
  @doc since: "0.2.0"
  def get_secret(params) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.get("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets/#{params[:secret_id]}", headers)  
  end

  @doc """
  Delete one account secret.

  ## Examples

      iex> Nexmo.Account.delete_secret(secret_id: "secret_id")

  ## Documentation

  Docs: [https://developer.nexmo.com/api/account#revokeAPISecret](https://developer.nexmo.com/api/account#revokeAPISecret?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#revoke-api-secret)
  """
  def delete_secret(params) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.delete("#{System.get_env("SECRETS_API_ENDPOINT")}/#{Nexmo.Config.api_key}/secrets/#{params[:secret_id]}", headers)
  end
end