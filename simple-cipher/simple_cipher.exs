defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    plaintext
    |> to_charlist
    |> solution(key, &cipher/2)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    ciphertext
    |> to_charlist
    |> solution(key, &(cipher(&1, -&2)))
  end

  def solution(text, key, func) do
    key
    |> String.pad_trailing(length(text), key)
    |> to_charlist
    |> Enum.zip(text)
    |> Enum.map(fn {k, l} -> func.(l, k) end)
    |> Enum.join
  end

  def cipher(letter, k) when letter in ?a..?z do
    case k do
      k when k >= 0 -> <<rem(letter - ?a + k - ?a, 26) + ?a ::utf8>>
      k when k < 0 -> <<Integer.mod(letter + k, 26) + ?a ::utf8>>
    end
  end
  def cipher(letter, _number), do: <<letter::utf8>>
end

