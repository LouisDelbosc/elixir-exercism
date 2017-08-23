defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(number) when number <= 0, do: raise "Wrong args"
  def nth(1), do: 2
  def nth(2), do: 3
  def nth(count), do: nth(count - 2, 3)

  def nth(count, number) do
    cond do
      prime?(number) && count == 1 -> number
      prime? number -> nth(count - 1, number + 1)
      true -> nth(count, number + 1)
    end
  end

  def prime?(2), do: true
  def prime?(number) when rem(number, 2) == 0, do: false
  def prime?(number) do
    limit = number |> :math.sqrt |> trunc
    2..limit
    |> Enum.all?(fn(x) -> rem(number, x) != 0 end)
  end
end
