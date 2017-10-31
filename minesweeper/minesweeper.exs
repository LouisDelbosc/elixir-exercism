defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
    board = board |> Enum.map(&String.graphemes/1)
    for {line, i} <- Enum.with_index(board) do
      for {cell, j} <- line |> Enum.with_index do
        if cell == "*", do: "*", else: annotate_cell(board, i, j)
      end
      |> Enum.join
    end
  end

  def annotate_cell(board, x, y) do
    {x, y}
    |> neighbours(board)
    |> Enum.filter(&(&1 == "*"))
    |> length
    |> (fn size -> if size == 0, do: " ", else: "#{size}" end).()
  end

  def neighbours({x, y}, board) do
    (for a <- -1..1, b <- -1..1, {a, b} != {0, 0}, do: {a, b})
    |> Enum.map(fn {a, b} -> {a + x, b + y} end)
    |> Enum.filter(fn {a, _b} -> a >= 0 and a < length(board) end)
    |> Enum.filter(fn {_a, b} -> b >= 0 and b < length(hd(board)) end)
    |> Enum.map(fn {a, b} -> board |> Enum.at(a) |> Enum.at(b) end)
  end
end
