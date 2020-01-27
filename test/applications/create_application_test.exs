defmodule Nexmo.Applications.CreateApplicationTest do
  use ExUnit.Case

  setup do
    api_key = "a123456"
    api_secret = "b123456"

    # setup test responses
    valid_response = 
      %{
        "id" => "78d335fa323d01149c3dd6f0d48968cf",
        "name" => "Demo Application",
        "capabilities" => %{
          "voice" => %{
            "webhooks" => %{
              "answer_url" => %{
                "address" => "https =>//example.com/webhooks/answer",
                "http_method" => "POST"
              },
              "event_url" => %{
                "address" => "https =>//example.com/webhooks/event",
                "http_method" => "POST"
              }
            }
          },
        },
        "keys" => %{
          "public_key" => "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCA\nKOxjsU4pf/sMFi9N0jqcSLcjxu33G\nd/vynKnlw9SENi+UZR44GdjGdmfm1\ntL1eA7IBh2HNnkYXnAwYzKJoa4eO3\n0kYWekeIZawIwe/g9faFgkev+1xsO\nOUNhPx2LhuLmgwWSRS4L5W851Xe3f\nUQIDAQAB\n-----END PUBLIC KEY-----\n",
          "private_key" => "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFA\nASCBKcwggSjAgEAAoIBAQDEPpvi+3\nRH1efQ\\nkveWzZDrNNoEXmBw61w+O\n0u/N36tJnN5XnYecU64yHzu2ByEr0\n7iIvYbavFnADwl\\nHMTJwqDQakpa3\n8/SFRnTDq3zronvNZ6nOp7S6K7pcZ\nrw/CvrL6hXT1x7cGBZ4jPx\\nqhjqY\nuJPgZD7OVB69oYOV92vIIJ7JLYwqb\n-----END PRIVATE KEY-----\n"
        }
      }

    # setup bypass 

    bypass = Bypass.open()
    orig_endpoint = System.get_env "APPLICATIONS_API_ENDPOINT"
    bypass_url = "http://localhost:#{bypass.port}"
    System.put_env "APPLICATIONS_API_ENDPOINT", bypass_url
    orig_api_key = System.get_env "NEXMO_API_KEY"
    System.put_env "NEXMO_API_KEY", api_key
    orig_api_secret = System.get_env "NEXMO_API_SECRET"
    System.put_env "NEXMO_API_SECRET", api_secret
    on_exit fn ->
      System.put_env "NEXMO_API_KEY", orig_api_key
      System.put_env "NEXMO_API_SECRET", orig_api_secret
      System.put_env "APPLICATIONS_API_ENDPOINT", orig_endpoint
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
      assert "/" == conn.request_path
      assert "POST" == conn.method
      Plug.Conn.send_resp(conn, 200, Poison.encode!(valid_response))
    end
    response = Nexmo.Applications.create(name: "Demo Application")
    assert valid_response == elem(response, 1).body
  end
end