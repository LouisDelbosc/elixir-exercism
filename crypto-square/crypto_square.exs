defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    str
    |> String.downcase
    |> String.replace(~r/[^\w]/, "")
    |> String.graphemes
    |> Enum.with_index
    |> group_by
    |> Map.values
    |> Enum.map_join(" ", fn row -> Enum.map(row, fn {x, _i} -> x end) end)
  end

  def group_by(array) do
    cut = array
    |> length
    |> :math.sqrt
    |> (fn
      x when trunc(x) * trunc(x) == length(array) -> trunc(x)
      x -> trunc(x) + 1
    end).()
    array
    |> Enum.group_by(fn {_v, i} -> rem(i, cut) end)
  end
end
