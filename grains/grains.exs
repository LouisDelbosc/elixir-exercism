defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def two_pow(1), do: 1
  def two_pow(number), do: 1..number-1 |> Enum.reduce(1, fn _, acc -> acc * 2 end)

  def square(number) when number > 64 or number < 1 do
    { :error, "The requested square must be between 1 and 64 (inclusive)" }
  end
  def square(number), do: {:ok, two_pow(number)}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    1..64
    |> Enum.reduce(0, fn pow, acc -> acc + two_pow(pow) end)
    |> (& {:ok, &1}).()
  end
end
