defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers) - 1)

  def search(_, key, first, last) when first > last, do: :not_found
  def search(numbers, key, first, last) do
    half = div(last + first, 2)
    cond do
      key == elem(numbers, half) -> {:ok, half}
      key <  elem(numbers, half) -> search(numbers, key, first, half - 1)
      key >  elem(numbers, half) -> search(numbers, key, half + 1, last)
    end
  end
end
