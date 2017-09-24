defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """
  @hexa_letter %{"a" => 10, "b" => 11, "c" => 12, "d" => 13, "e" => 14, "f" => 15}

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    hex
    |> String.downcase
    |> String.graphemes
    |> to_decimal(0)
  end

  def to_decimal([], acc), do: acc
  def to_decimal([h|t], acc) do
    case h do
      h when h in ~w(1 2 3 4 5 6 7 8 9 0) ->
        to_decimal(t, acc * 16 + String.to_integer(h))
      h when h in ~w(a b c d e f) ->
        to_decimal(t, acc * 16 + @hexa_letter[h])
      _ -> 0
    end
  end
end
