defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(_, 0), do: [] |> format_change
  def generate(coins, target) do
    1..target
    |> Enum.reduce(%{0 => []}, fn val, acc -> solution(val, acc, coins) end)
    |> get_in([target])
    |> format_change
  end

  def solution(target, solutions, coins) do
    coins
    |> Enum.filter(&(solutions[target - &1]))
    |> Enum.map(fn coin -> [ coin | solutions[target - coin] ] end)
    |> Enum.min_by(&length/1, fn -> nil end)
    |> (&(Map.put(solutions, target, &1))).()
  end

  def format_change(nil), do: {:error, "cannot change"}
  def format_change(change), do: {:ok, change}
end
