defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    (for n <- 1..limit-1, multiple?(n, factors), do: n)
    |> Enum.sum
  end

  defp multiple?(n, factors), do: Enum.any?(factors, &(rem(n, &1) === 0))
end
