defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal("", acc), do: acc
  def to_decimal("1" <> rest, acc), do: to_decimal(rest, acc * 2 + 1)
  def to_decimal("0" <> rest, acc), do: to_decimal(rest, acc * 2)
  def to_decimal(str, acc), do: 0
  def to_decimal(str), do: to_decimal(str, 0)
end
