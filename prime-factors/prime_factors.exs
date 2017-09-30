defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, 2)
  end

  defp factors_for(1, _), do: []
  defp factors_for(n, i) when n < i * i, do: [n]
  defp factors_for(n, i) when rem(n, i) == 0, do: [ i | factors_for(div(n, i), i)]
  defp factors_for(n, i), do: factors_for(n, i + 1)
end
