defmodule Nexmo.Account.DeleteSecretTest do
  use ExUnit.Case

  setup do
    api_key = "a123456"
    api_secret = "b123456"

    # setup test responses
    valid_response = %{}

    # setup bypass 

    bypass = Bypass.open()
    orig_endpoint = System.get_env "SECRETS_API_ENDPOINT"
    bypass_url = "http://localhost:#{bypass.port}/accounts"
    System.put_env "SECRETS_API_ENDPOINT", bypass_url
    orig_api_key = System.get_env "NEXMO_API_KEY"
    System.put_env "NEXMO_API_KEY", api_key
    orig_api_secret = System.get_env "NEXMO_API_SECRET"
    System.put_env "NEXMO_API_SECRET", api_secret
    on_exit fn ->
      System.put_env "NEXMO_API_KEY", orig_api_key
      System.put_env "NEXMO_API_SECRET", orig_api_secret
      System.put_env "SECRETS_API_ENDPOINT", orig_endpoint
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
      assert "/accounts/#{System.get_env("NEXMO_API_KEY")}/secrets/123a-456b-789c-12345d" == conn.request_path
      assert "DELETE" == conn.method
      Plug.Conn.send_resp(conn, 200, Poison.encode!(valid_response))
    end
    response = Nexmo.Account.delete_secret(secret_id: "123a-456b-789c-12345d")
    assert valid_response == elem(response, 1).body
  end
end