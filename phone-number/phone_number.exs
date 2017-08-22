defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """

  @invalid_number "0000000000"

  @spec number(String.t) :: String.t
  def number(raw) do
    if not Regex.match?(~r/[a-zA-Z]/, raw) do
      raw
      |> String.replace(~r/(\+|\(|\)| |\-|\.)/, "")
      |> phone_number
    else
      @invalid_number
    end
  end

  def phone_number("1" <> number) when byte_size(number) == 10, do: number
  def phone_number(number) when byte_size(number) == 10 do
    case number do
      "1" <> _ -> @invalid_number
      "0" <> _ -> @invalid_number
      <<_::binary-size(3)>> <> "1" <> _ -> @invalid_number
      <<_::binary-size(3)>> <> "0" <> _ -> @invalid_number
      _ -> number
    end
  end
  def phone_number(_), do: @invalid_number

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    <<area_number::binary-size(3)>> <> _ = number(raw)
    area_number
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    <<area::binary-size(3)>> <> <<local::binary-size(3)>> <> rest = number(raw)
    "(#{area}) #{local}-#{rest}"
  end
end
