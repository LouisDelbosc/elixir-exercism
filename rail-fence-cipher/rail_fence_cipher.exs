defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, 1), do: str
  def encode(str, rails) do
    rails
    |> railway(byte_size(str))
    |> Enum.map(fn rail_position -> String.at(str, rail_position) end)
    |> Enum.join
  end

  def railway(rails, length) do
    1..rails
    |> Enum.map(fn n -> one_rail(n - 1, (rails - n) * 2, (n - 1) * 2, length - 1) end)
    |> List.flatten
  end

  def one_rail(start, first_jump, second_jump, limit, acc \\ [])
  def one_rail(start, _, _, limit, acc) when start > limit, do: acc |> Enum.uniq
  def one_rail(start, first_jump, second_jump, limit, acc) do
    one_rail(start + first_jump, second_jump, first_jump, limit, acc ++ [start])
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode("", _), do: ""
  def decode(str, 1), do: str
  def decode(str, rails) do
    str
    |> String.graphemes
    |> Enum.zip(railway(rails, byte_size(str)))
    |> Enum.sort(fn {_, index1}, {_, index2} -> index1 < index2 end)
    |> Enum.map_join(fn {a, _index} -> a end)
  end
end
