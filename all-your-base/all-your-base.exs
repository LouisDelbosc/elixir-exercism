defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, a, b) when a <= 1 or b <= 1, do: nil
  def convert(digits, base_a, base_b) do
    cond do
      Enum.all?(digits, &(&1 == 0)) -> [0]
      Enum.any?(digits, &(&1 >= base_a or &1 < 0)) -> nil
      true -> digits |> to_base10(base_a) |> from_base10(base_b)
    end
  end

  def to_base10(digits, base) do
    digits
    |> Enum.reduce(0, fn(value, acc) -> acc * base + value end)
  end

  def from_base10(0, _), do: []
  def from_base10(number, base) do
    from_base10(div(number, base), base) ++ [rem(number, base) ]
  end
end
