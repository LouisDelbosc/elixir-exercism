defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(_, size) when size < 0, do: raise ArgumentError, "trop grand"
  def largest_product(number_string, size) when byte_size(number_string) < size do
    raise ArgumentError, "trop grand"
  end
  def largest_product(number_string, size) do
    number_string
    |> String.graphemes
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(fn serie ->
      Enum.reduce(serie, 1, &(String.to_integer(&1) * &2))
    end)
    |> Enum.max
  end
end
