defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  import String  # To have a more readable list comprehension

  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    for word <- candidates, anagram?(downcase(base), downcase(word)), do: word
  end

  def anagram?(word1, word2) when word1 === word2, do: false
  def anagram?(word1, word2) do
    word1_minus_word2 = String.graphemes(word1) -- String.graphemes(word2)
    word2_minus_word1 = String.graphemes(word2) -- String.graphemes(word1)
    {word1_minus_word2, word2_minus_word1} === {[], []}
  end
end
