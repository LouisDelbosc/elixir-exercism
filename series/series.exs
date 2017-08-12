defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  # def slices(_, size) when size <= 0, do: []
  def slices(_, size) when 0 >= size, do: []
  def slices(s, size) when byte_size(s) < size, do: []
  def slices(s, size) do
    last = String.length(s) - size
    for pos <- 0..last , do: String.slice(s, pos..(pos + size - 1))
  end
end

