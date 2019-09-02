defmodule Nexmo.Sms do
  use HTTPoison.Base

  def send(from, to, text) do
    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Accept", "text/html"}
    ]
    params = [
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret,
      from: from,
      to: to,
      text: text
    ]
    encoded_text = URI.encode_query(params)
    Nexmo.Sms.post(System.get_env("SMS_API_ENDPOINT"), encoded_text, headers)
  end
end