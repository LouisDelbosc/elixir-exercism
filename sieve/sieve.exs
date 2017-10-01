defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit, i \\ 2)
  def primes_to(limit, i) when limit < i, do: []
  def primes_to(limit, i) do
    if prime?(i), do: [ i | primes_to(limit, i + 1) ], else: primes_to(limit, i + 1)
  end

  def prime?(n) when n in [2, 3], do: true
  def prime?(n) do
    2..n
    |> Enum.filter(fn x -> x <= :math.sqrt(n) end)
    |> Enum.all?(fn x -> rem(n, x) != 0 end)
  end

end
