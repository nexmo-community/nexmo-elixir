defmodule Nexmo do
  def merge_credentials(params) do
    params = convert_to_map(params)
    Map.merge(params, %{
      api_key: Nexmo.Application.api_key,
      api_secret: Nexmo.Application.api_secret
    })
  end

  def convert_to_map(params) do
    for {key, val} <- params, into: %{} do
      cond do
        is_atom(key) -> {key, val}
        true -> {String.to_atom(key), val}
      end
    end
  end
end
