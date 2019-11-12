defmodule Nexmo.NumberInsight.BasicTest do
  use ExUnit.Case

  setup do
    api_key = "a123456"
    api_secret = "b123456"

    # setup test responses
    valid_response = %{
      "country_code" => "IL",
      "country_code_iso3" => "ISR",
      "country_name" => "Israel",
      "country_prefix" => "972",
      "international_format_number" => "972589999999",
      "national_format_number" => "058-999-9999",
      "request_id" => "abcd-efgh-1234-5678",
      "status" => 0,
      "status_message" => "Success"
    }

    # setup bypass 

    bypass = Bypass.open()
    orig_endpoint = System.get_env "NUMBER_INSIGHT_API_ENDPOINT"
    bypass_url = "http://localhost:#{bypass.port}"
    System.put_env "NUMBER_INSIGHT_API_ENDPOINT", bypass_url
    orig_api_key = System.get_env "NEXMO_API_KEY"
    System.put_env "NEXMO_API_KEY", api_key
    orig_api_secret = System.get_env "NEXMO_API_SECRET"
    System.put_env "NEXMO_API_SECRET", api_secret
    on_exit fn ->
      System.put_env "NEXMO_API_KEY", orig_api_key
      System.put_env "NEXMO_API_SECRET", orig_api_secret
      System.put_env "NUMBER_INSIGHT_API_ENDPOINT", orig_endpoint
    end
    {:ok, %{
      api_key: api_key,
      api_secret: api_secret,
      bypass: bypass,
      valid_response: valid_response
    }}
  end

  test "sends valid request to Nexmo", %{
    bypass: bypass,
    valid_response: valid_response
  } do
    Bypass.expect bypass, fn conn ->
      assert "/basic/json" == conn.request_path
      assert "api_key=a123456&api_secret=b123456&number=972589999999" == conn.query_string
      assert "GET" == conn.method
      Plug.Conn.send_resp(conn, 200, Poison.encode!(valid_response))
    end
    response = Nexmo.NumberInsight.basic(%{number: "972589999999"})
    assert valid_response == elem(response, 1).body
  end
end