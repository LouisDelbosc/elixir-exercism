defmodule Connect do
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
    |> (fn line -> for {elem, i} <- Enum.with_index(line), elem == "O", do: {0, i} end).()
    |> Enum.map(fn pos -> extracts_chains(pos, board, "O", MapSet.new([pos])) end)
    |> Enum.any?(fn chain -> Enum.any?(chain, fn {x, _y} -> x == length(board) - 1 end) end)
  end

  def win?(:black, board) do
    board
    |> Enum.map(&hd/1)
    |> (fn line -> for {elem, i} <- Enum.with_index(line), elem == "X", do: {i, 0} end).()
    |> Enum.map(fn pos -> extracts_chains(pos, board, "X", MapSet.new([pos])) end)
    |> Enum.any?(fn chain -> Enum.any?(chain, fn {_x, y} -> y == length(hd(board)) - 1 end)
    end)
  end

  def get_cells({x, y}, board), do: board |> Enum.at(x) |> Enum.at(y)

  def extracts_chains([], _, _, acc), do: acc
  def extracts_chains(position, index_board, color, acc) do
    position
    |> neighbours(index_board)
    |> Enum.filter(fn {x, y} -> get_cells({x, y}, index_board) == color end)
    |> Enum.filter(fn pos -> pos not in acc end)
    |> (fn pos -> Enum.reduce(pos, MapSet.union(acc, MapSet.new(pos)),
fn v, a -> MapSet.union(a, extracts_chains(v, index_board, color, a))
end)
    end).()

  end

  def neighbours({x, y}, index_board) do
    (for a <- -1..1, b <- -1..1, {a, b} != {0, 0}, do: {a, b})
    |> Enum.map(fn {a, b} -> {a + x, b + y} end)
    |> Enum.filter(fn {a, _b} -> a >= 0 and a < length(index_board) end)
    |> Enum.filter(fn {_a, b} -> b >= 0 and b < length(hd(index_board)) end)
  end
end
