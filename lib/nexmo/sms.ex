defmodule Nexmo.Sms do
  use HTTPoison.Base
  
  def process_response_body(body) do
    JSX.decode!(body)
  end

  def send(params) do
    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Accept", "text/html"}
    ]
    params = Nexmo.Config.merge_credentials(params)
    encoded_text = URI.encode_query(params)
    Nexmo.Sms.post(System.get_env("SMS_API_ENDPOINT"), encoded_text, headers)
  end
end