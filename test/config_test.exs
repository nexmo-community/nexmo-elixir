defmodule NexmoConfigTest do
  use ExUnit.Case

  alias Nexmo.Config

  setup do
    api_key = "a123456"
    api_secret = "b123456"
    actual_key = System.get_env("NEXMO_API_KEY")
    System.put_env("NEXMO_API_KEY", api_key)
    actual_secret = System.get_env("NEXMO_API_SECRET")
    System.put_env("NEXMO_API_SECRET", api_secret)
    on_exit fn ->
      System.put_env("NEXMO_API_KEY", actual_key)
      System.put_env("NEXMO_API_SECRET", actual_secret)
    end
  end

  test "api_key function returns correct API key" do
    assert Config.api_key == "a123456"
  end

  test "api_secret function returns correct API secret" do
    assert Config.api_secret == "b123456"
  end

  test "merge credentials function combines user input with Nexmo credentials" do
    input = %{a: "123", b: "456"}
    expected_result = %{a: "123", b: "456", api_key: "a123456", api_secret: "b123456"}
    result = Nexmo.Config.merge_credentials(input)
    
    assert result == expected_result
  end
end