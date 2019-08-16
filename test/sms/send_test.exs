defmodule Nexmo.Sms.SendTest do
  use ExUnit.Case

  setup do
    api_key = "a123456"
    api_secret = "b123456"
    to = "12121231234"
    from = "NexmoElixir"
    text = "Hello World"

    # setup test responses
    valid_response =
      %{
        "message-count" => "1",
        "messages" => [
          %{
            "status" => "0",
            "message-id" => "123",
            "to" => "#{to}",
            "client-ref" => "234234",
            "remaining-balance" => "22344",
            "message-price" => "345",
            "network" => "network",
            "error-text" => "error-message"
          }
        ]
      }

    # setup bypass 

    bypass = Bypass.open()
    orig_endpoint = System.get_env "SMS_API_ENDPOINT"
    bypass_url = "http://localhost:#{bypass.port}/sms/json"
    System.put_env "SMS_API_ENDPOINT", bypass_url
    orig_api_key = System.get_env "NEXMO_API_KEY"
    System.put_env "NEXMO_API_KEY", api_key
    orig_api_secret = System.get_env "NEXMO_API_SECRET"
    System.put_env "NEXMO_API_SECRET", api_secret
    on_exit fn ->
      System.put_env "NEXMO_API_KEY", orig_api_key
      System.put_env "NEXMO_API_SECRET", orig_api_secret
      System.put_env "SMS_API_ENDPOINT", orig_endpoint
    end
    {:ok, %{
      api_key: api_key,
      api_secret: api_secret,
      to: to,
      from: from,
      text: text,
      bypass: bypass,
      valid_response: valid_response
    }}
  end

  test "sends valid request to Nexmo", %{
    from: from,
    to: to,
    text: text,
    bypass: bypass,
    valid_response: valid_response
  } do
    Bypass.expect bypass, fn conn ->
      assert "/sms/json" == conn.request_path
      assert "" == conn.query_string
      assert "POST" == conn.method
      assert {"content-type", "application/x-www-form-urlencoded"} in conn.req_headers
      Plug.Conn.send_resp(conn, 200, Poison.encode!(valid_response))
    end
    response = Nexmo.Sms.send(from, to, text)
    assert valid_response == elem(response, 1).body
  end
end