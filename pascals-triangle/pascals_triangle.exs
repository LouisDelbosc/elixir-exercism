defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(1), do: [[1]]
  def rows(num) do
    1..num-1
    |> Enum.reduce([[1]], fn _, acc = [h|_] -> [ next_row(h) | acc ] end)
    |> Enum.reverse
  end

  def next_row(previous_row) do
    previous_row
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> (&([1] ++ &1 ++ [1])).()
  end
end
