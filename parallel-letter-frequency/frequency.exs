defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Task.async_stream(fn ts -> ts |> normalize |> count end, max_concurrency: workers)
    |> Enum.reduce(%{}, fn {:ok, c}, acc -> Map.merge(c, acc, fn _, a, b -> a + b end) end)
  end

  @spec normalize(String.t) :: String.t
  def normalize(text) do
    text
    |> String.downcase
    |> String.replace(~r/[[:digit:][:space:]\p{P}\p{S}]/, "")
    |> String.graphemes
  end

  @spec count(String.t) :: map
  def count(list) do
    list
    |> Enum.reduce(%{}, fn letter, acc -> Map.update(acc, letter, 1, &(&1 + 1)) end)
  end
end
