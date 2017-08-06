defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  def count(words, word) do
    Enum.count(words, &(&1 == word))
  end

  @spec count(String.t) :: map
  def count(sentence) do
    words = sentence
    |> String.downcase
    |> String.replace("_", " ")
    |> String.split(~r/(*UTF8)[^\w-]/, trim: true)
    Map.new(words, fn(word) -> {word, count(words, word)} end)
  end
end
