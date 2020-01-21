defmodule Nexmo.Applications do
  @moduledoc """
  The `Nexmo.Applications` module provides management of your Nexmo Applications.
  """
  @moduledoc since: "0.2.0"
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  @doc """
  Create an application.

  ## Examples

      iex> Nexmo.Applications.create(
        name: 'Example App',
        type: 'voice',
        answer_url: answer_url,
        event_url: event_url
      )

  ## Documentation

  Docs: [https://developer.nexmo.com/api/application.v2#createApplication](https://developer.nexmo.com/api/application.v2#createApplication?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#create-application)  
  """
  @doc since: "0.4.0"  
  def create(params) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [
      {"Content-Type", "Application/json"},
      {"Authorization", "Basic #{credentials}"}
    ]
    body = Enum.into(params, %{})
    Nexmo.Account.post("#{System.get_env("APPLICATIONS_API_ENDPOINT")}", Poison.encode!(body), headers)
  end

  @doc """
  List available applications.

  ## Examples

      iex> Nexmo.Applications.list()

  ## Documentation

  Docs: [https://developer.nexmo.com/api/application.v2#listApplication](https://developer.nexmo.com/api/application.v2#listApplication?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#list-applications)
  """
  @doc since: "0.4.0"  
  def list() do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.get("#{System.get_env("APPLICATIONS_API_ENDPOINT")}", headers)  
  end

  @doc """
  Get an application.

  ## Examples

      iex> Nexmo.Applications.get(application_id: "secret_id")

  ## Documentation
  
  Docs: [https://developer.nexmo.com/api/application.v2#getApplication](https://developer.nexmo.com/api/application.v2#getApplication?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#get-application)
  """
  @doc since: "0.4.0"
  def get(params) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Account.get("#{System.get_env("APPLICATIONS_API_ENDPOINT")}/#{params[:application_id]}", headers)  
  end

  @doc """
  Update an application.

  ## Examples

      iex> Nexmo.Applications.update(
        application_id: "application_id",
        answer_method: "POST"
      )

  ## Documentation

  Docs: [https://developer.nexmo.com/api/application.v2#updateApplication](https://developer.nexmo.com/api/application.v2#updateApplication?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#update-application)
  """
  @doc since: "0.4.0"
  def update(params) do
    params = Nexmo.Config.merge_credentials(params)
    body = Enum.into(params, %{})
    Nexmo.Account.post("#{System.get_env("APPLICATIONS_API_ENDPOINT")}/#{params[:application_id]}", Poison.encode!(body), [], params: params)
  end

  @doc """
  Delete an application. This action cannot be undone.

  ## Examples

      iex> Nexmo.Applications.delete(application_id: "application_id")

  ## Documentation

  Docs: [https://developer.nexmo.com/api/application.v2#deleteApplication](https://developer.nexmo.com/api/application.v2#deleteApplication?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#delete-application)
  """
  @doc since: "0.4.0"
  def delete(params) do
    credentials = "#{Nexmo.Config.api_key}:#{Nexmo.Config.api_secret}" |> Base.encode64()
    headers = [{"Authorization", "Basic #{credentials}"}]
    Nexmo.Applications.delete("#{System.get_env("APPLICATIONS_API_ENDPOINT")}/#{params[:application_id]}", headers)
  end
end