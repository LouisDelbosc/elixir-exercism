defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    for n <- min_factor..max_factor, m <- min_factor..n, palindrome?(n * m),
      into: %{} do
        {[m, n], n * m}
    end
    |> Enum.reduce(%{}, fn {k, v}, acc -> Map.update(acc, v, [k], &([ k | &1 ])) end)
  end

  def palindrome?(number) do
    digits = number |> Integer.digits
    digits
    |> Enum.reverse
    |> Kernel.==(digits)
  end
end
