defmodule Nexmo.Sms do
  @moduledoc """
  This module provides Nexmo SMS API functionality.
  """
  @moduledoc since: "0.1.0"
  use HTTPoison.Base
  
  def process_response_body(body) do
    JSX.decode!(body)
  end

  @doc """
  Send an SMS through the Nexmo SMS API.

  ## Examples

      iex> Nexmo.Sms.send(
        from: YOUR_NUMBER,
        to: RECIPIENT_NUMBER,
        text: TEXT_MESSAGE
      )
  
  ## Documentation

  Docs: [https://developer.nexmo.com/api/sms#send-an-sms](https://developer.nexmo.com/api/sms?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#send-an-sms)
  """
  @doc since: "0.1.0"
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