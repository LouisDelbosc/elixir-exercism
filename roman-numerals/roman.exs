defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  @mapping %{
    1 => "I",
    5 => "V",
    10 => "X",
    50 => "L",
    100 => "C",
    500 => "D",
    1000 => "M",
  }

  def numerals(number) do
    reverse_digits = number |> Integer.digits |> Enum.reverse
    (for {digit, index} <- Enum.with_index(reverse_digits), do: mapping_digit(digit, index))
    |> Enum.reverse
    |> Enum.join
  end

  def mapping_digit(digit, index) when index >= 3 do
    unit = trunc(:math.pow(10, index))
    roman_digit(digit, @mapping[unit], "", "")
  end
  def mapping_digit(digit, index) do
    unit = trunc(:math.pow(10, index))
    five = trunc(:math.pow(10, index) * 5)
    ten  = trunc(:math.pow(10, index + 1))
    roman_digit(digit, @mapping[unit], @mapping[five], @mapping[ten])
  end

  def roman_digit(4, letter_one, letter_five, _), do: "#{letter_one}#{letter_five}"
  def roman_digit(9, letter_one, _, letter_ten), do: "#{letter_one}#{letter_ten}"
  def roman_digit(n, letter_one, _, _) when n <= 3, do: String.duplicate "#{letter_one}", n
  def roman_digit(n, letter_one, letter_five, _) do
    five = if n >= 5, do: "#{letter_five}", else: ""
    other = String.duplicate "#{letter_one}", rem(n, 5)
    "#{five}#{other}"
  end
end
