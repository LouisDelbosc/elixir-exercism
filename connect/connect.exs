defmodule Connect do
  alias MapSet, as: MS
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(board) do
    board_matrix = board |> Enum.map(&String.graphemes/1)

    cond do
      win?(:white, board_matrix) -> :white
      win?(:black, board_matrix) -> :black
      true -> :none
    end

  end

  def win?(:white, board) do
    board
    |> Enum.at(0)
    |> (& for {elem, i} <- Enum.with_index(&1), elem == "O", do: {0, i}).()
    |> Enum.map(fn pos -> extracts_chains(pos, board, "O", MS.new([pos])) end)
    |> Enum.any?(& Enum.any?(&1, fn {x, _y} -> x == length(board) - 1 end))
  end

  def win?(:black, board) do
    board
    |> Enum.map(&hd/1)
    |> (& for {elem, i} <- Enum.with_index(&1), elem == "X", do: {i, 0}).()
    |> Enum.map(fn pos -> extracts_chains(pos, board, "X", MS.new([pos])) end)
    |> Enum.any?(& Enum.any?(&1, fn {_x, y} -> y == length(hd(board)) - 1 end))
  end

  def extracts_chains([], _, _, acc), do: acc
  def extracts_chains(position, board, color, acc) do
    position
    |> neighbours(board)
    |> Enum.filter(fn {x, y} -> board |> Enum.at(x) |> Enum.at(y) == color end)
    |> Enum.filter(& &1 not in acc)
    |> (& Enum.reduce(&1, MS.union(acc, MS.new(&1)),
          fn v, a -> MS.union(a, extracts_chains(v, board, color, a))end)).()

  end

  def neighbours({x, y}, index_board) do
    (for a <- -1..1, b <- -1..1, {a, b} != {0, 0}, do: {a, b})
    |> Enum.map(fn {a, b} -> {a + x, b + y} end)
    |> Enum.filter(fn {a, _b} -> a >= 0 and a < length(index_board) end)
    |> Enum.filter(fn {_a, b} -> b >= 0 and b < length(hd(index_board)) end)
  end
end
