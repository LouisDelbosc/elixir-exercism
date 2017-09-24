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
  @hexa %{
    "0" => 0, "1" => 1, "2" => 2, "3" => 3,
    "4" => 4, "5" => 5, "6" => 6, "7" => 7,
    "8" => 8, "9" => 9, "a" => 10, "b" => 11,
    "c" => 12, "d" => 13, "e" => 14, "f" => 15,
  }

  @spec to_decimal(binary) :: integer
  def to_decimal(hex), do: hex |> String.downcase |> to_decimal(0)

  for {hex_number, dec_value} <- @hexa do
    def to_decimal(unquote(hex_number) <> rest, acc) do
      to_decimal(rest, acc * 16 + unquote(dec_value))
    end
  end
  def to_decimal("", acc), do: acc
  def to_decimal(_unknown, _useless), do: 0
end
