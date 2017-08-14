defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase
    |> String.graphemes
    |> Enum.reduce(0, fn(letter, acc) -> acc + letter_score(letter) end)
  end

  defp letter_score(letter) when letter in ~w(a e i o u l n r s t), do: 1
  defp letter_score(letter) when letter in ~w(d g), do: 2
  defp letter_score(letter) when letter in ~w(b c m p), do: 3
  defp letter_score(letter) when letter in ~w(f h v w y), do: 4
  defp letter_score(letter) when letter in ~w(k), do: 5
  defp letter_score(letter) when letter in ~w(j x), do: 8
  defp letter_score(letter) when letter in ~w(q z), do: 10
  defp letter_score(_), do: 0
end
