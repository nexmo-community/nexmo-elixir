defmodule Nexmo.NumberInsight do
  @moduledoc """
  This module provides Nexmo Number Insight API functionality.
  """
  @moduledoc since: "0.3.0"
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  @doc """
  Access the Basic level of the Nexmo Number Insight API.

  ## Examples

      iex> Nexmo.NumberInsight.basic(number: "447700900000")
  
  ## Documentation

  Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightBasic](https://developer.nexmo.com/api/number-insight#getNumberInsightBasic?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightBasic)
  """
  @doc since: "0.3.0"
  def basic(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/basic/json", [], params: params)  
  end

  @doc """
  Access the Standard level of the Nexmo Number Insight API.

  ## Examples

      iex> Nexmo.NumberInsight.standard(number: "447700900000")

  ## Documentation

  Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightStandard](https://developer.nexmo.com/api/number-insight#getNumberInsightStandard?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightStandard)
  """
  @doc since: "0.3.0"
  def standard(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/standard/json", [], params: params)  
  end

  @doc """
  Access the Advanced level of the Nexmo Number Insight API.

  ## Examples

      iex> Nexmo.NumberInsight.advanced(number: "447700900000")

  ## Documentation

  Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightAdvanced](https://developer.nexmo.com/api/number-insight#getNumberInsightAdvanced?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightAdvanced)
  """
  @doc since: "0.3.0"
  def advanced(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/advanced/json", [], params: params)  
  end

  @doc """
  Access the Advanced Async level of the Nexmo Number Insight API. In addition to a phone number, a callback
  URL must be provided in the params.

  ## Examples

      iex> Nexmo.NumberInsight.advanced_async(
        number: "447700900000",
        callback: "https://example.com/callback"
      )
  
  ## Documentation

  Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightAsync](https://developer.nexmo.com/api/number-insight#getNumberInsightAsync?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightAsync)
  """
  def advanced_async(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/advanced/async/json", [], params: params)  
  end
end