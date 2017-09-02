defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/[^a-z]/, "")
    |> String.graphemes
    |> isogram?([])
  end

  def isogram?([], _), do: true
  def isogram?([ h | t ], acc) do
    if h in acc, do: false, else: isogram?(t, [ h | acc ])
  end

end
