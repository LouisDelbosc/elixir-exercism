defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number <> "0"
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse
    |> Enum.map_every(2, fn digit
      -> if digit * 2 > 9, do: (digit * 2 - 9), else: digit * 2
    end)
    |> Enum.sum
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    if number |> checksum |> rem(10) == 0, do: true, else: false
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    number <> "0"
    |> checksum
    |> rem(10)
    |> (&rem(10 - &1, 10)).()
    |> (&number <> to_string(&1)).()
  end
end
