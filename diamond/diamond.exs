defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter), do: build_shape(?A, letter, ?A)

  def build_shape(first, last, last), do: row(last - first, last, last - first)
  def build_shape(first, last, current) do
    current_row = row(last - first, current, current - first)
    current_row <> build_shape(first, last, current + 1) <> current_row
  end

  def row(half, letter, difference) do
    " "
    |> List.duplicate(half * 2 + 1)
    |> List.replace_at(half + difference, <<letter :: utf8>>)
    |> List.replace_at(half - difference, <<letter :: utf8>>)
    |> Enum.join
    |> Kernel.<>("\n")
  end
end
