defmodule Nexmo.NumberInsight do
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  def basic(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/basic/json", [], params: params)  
  end

  def standard(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/standard/json", [], params: params)  
  end

  def advanced(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/advanced/json", [], params: params)  
  end

  def advanced_async(params) do
    params = Nexmo.Config.merge_credentials(params)
    Nexmo.NumberInsight.get("#{System.get_env("NUMBER_INSIGHT_API_ENDPOINT")}/advanced/async/json", [], params: params)  
  end
end