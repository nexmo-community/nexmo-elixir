defmodule Nexmo.NumberInsight.AdvancedAsyncTest do
  use ExUnit.Case

  setup do
    api_key = "a123456"
    api_secret = "b123456"

    # setup test responses
    valid_response = %{
      {
        "status": 0,
        "status_message": "Success",
        "request_id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
        "international_format_number": "447700900000",
        "national_format_number": "07700 900000",
        "country_code": "GB",
        "country_code_iso3": "GBR",
        "country_name": "United Kingdom",
        "country_prefix": "44",
        "request_price": "0.04000000",
        "refund_price": "0.01500000",
        "remaining_balance": "1.23456789",
        "current_carrier": {
          "network_code": "12345",
          "name": "Acme Inc",
          "country": "GB",
          "network_type": "mobile"
        },
        "original_carrier": {
          "network_code": "12345",
          "name": "Acme Inc",
          "country": "GB",
          "network_type": "mobile"
        },
        "ported": "not_ported",
        "roaming": {
          "status": "roaming",
          "roaming_country_code": "US",
          "roaming_network_code": 12345,
          "roaming_network_name": "Acme Inc"
        },
        "caller_identity": {
          "caller_type": "consumer",
          "caller_name": "John Smith",
          "first_name": "John",
          "last_name": "Smith"
        },
        "lookup_outcome": "0",
        "lookup_outcome_message": "Success",
        "valid_number": "valid",
        "reachable": "reachable",
        "ip": {
          "address": "123.0.0.255",
          "ip_match_level": "country",
          "ip_country": "GB",
          "ip_city": "London"
        },
        "ip_warnings": "unknown"
      }
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
      assert "/advanced/json" == conn.request_path
      assert "api_key=a123456&api_secret=b123456&number=447700900000" == conn.query_string
      assert "GET" == conn.method
      Plug.Conn.send_resp(conn, 200, Poison.encode!(valid_response))
    end
    response = Nexmo.NumberInsight.advanced_async(%{number: "447700900000"})
    assert valid_response == elem(response, 1).body
  end
end