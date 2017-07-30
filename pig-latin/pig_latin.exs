defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(word) do
    split_index = cond do
      String.starts_with?(word, ~w(a e i o u yt xr)) -> 0
      String.starts_with?(word, ~w(chr squ thr sch)) -> 3
      String.starts_with?(word, ~w(ch qu th)) -> 2
      true -> 1
    end
    { prefix, rest} = String.split_at(word, split_index)
    "#{rest}#{prefix}ay"
  end
end
