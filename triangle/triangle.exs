defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: { :error, "all side lengths must be positive" }
  def kind(a, a, a), do: {:ok, :equilateral}
  def kind(a, b, c) do
    [biggest | rest] = Enum.sort([a, b, c], &(&1 >= &2))
    cond do
      biggest >= Enum.sum(rest) -> { :error, "side lengths violate triangle inequality" }
      a == b or b == c or a == c -> {:ok, :isosceles}
      true -> {:ok, :scalene}
    end
  end
end
