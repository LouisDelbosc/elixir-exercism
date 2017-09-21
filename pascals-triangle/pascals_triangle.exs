defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(1), do: [[1]]
  def rows(num) do
    1..num-1
    |> Enum.reduce([[1]], fn _, acc = [h|t] -> [ next_row(h) | acc ] end)
    |> Enum.reverse
  end

  def next_row([], acc, previous_value), do: [ previous_value | acc ]
  def next_row([h|t], acc, previous_value) do
    next_row(t, [ previous_value + h | acc ], h)
  end
  def next_row(previous_row), do: next_row(previous_row, [], 0)
end
