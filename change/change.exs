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
  def generate(coins, target) do
    sorted_coins = Enum.sort(coins, &(&1 > &2))
    case solution(sorted_coins, target, []) do
      x when x !== nil -> {:ok, x}
      _ -> {:error, "cannot change"}
    end
  end

  def solution(_, 0, acc), do: acc
  def solution([], target, _acc) when target != 0, do: nil
  def solution([h|t], target, acc) when h > target, do: solution(t, target, acc)
  def solution([h|t], target, acc) do
    first = solution(t, target, acc)
    second = solution([h|t], target - h, [h|acc])
    case {first, second} do
      {nil, _} -> second
      {_, nil} -> first
      _ -> if length(first) < length(second), do: first, else: second
    end
  end
end
