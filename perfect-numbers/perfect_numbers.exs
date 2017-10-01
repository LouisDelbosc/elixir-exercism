defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: ({ :ok, atom } | { :error, String.t() })
  def classify(1), do: {:ok, :deficient}
  def classify(number) when number < 1 do
    { :error, "Classification is only possible for natural numbers." }
  end

  def classify(number) do
    number
    |> divider
    |> Enum.uniq
    |> Enum.sum
    |> (fn
      sum when sum > number -> {:ok, :abundant}
      sum when sum < number -> {:ok, :deficient}
      sum when sum == number -> {:ok, :perfect}
    end).()
  end

  def divider(number, i \\ 2)
  def divider(number, i) when i * i > number, do: [1]
  def divider(number, i) when rem(number, i) != 0, do: divider(number, i + 1)
  def divider(number, i), do: [ i, div(number, i) | divider(number, i + 1) ]
end

