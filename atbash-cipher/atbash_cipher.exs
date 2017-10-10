defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    alphabet = ?a..?z |> Enum.map(fn l -> <<l::utf8>> end)
    plaintext
    |> String.downcase
    |> String.graphemes
    |> Enum.reduce([], fn letter, acc -> reduce_fnc(letter, acc, alphabet) end)
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t) :: String.t
  def decode(cipher) do
    alphabet = ?z..?a |> Enum.map(fn l -> <<l::utf8>> end)
    cipher
    |> String.graphemes
    |> Enum.reduce([], fn letter, acc -> reduce_fnc(letter, acc, alphabet) end)
    |> Enum.join
  end

  def reduce_fnc(letter, acc, alphabet) do
    cond do
      letter =~ ~r/[a-z]/ -> acc ++ [transform(alphabet, letter)]
      letter =~ ~r/[\d]/ -> acc ++ [letter]
      true -> acc
    end
  end

  def transform(source, letter) do
    source
    |> Enum.find_index(fn x -> x == letter end)
    |> (fn index -> Enum.at(source, -(index + 1)) end).()
  end
end
