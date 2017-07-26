defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  def shift_letter(char, shift) do
    cond do
      char in ?a..?z -> rem(char - ?a + shift, 26) + ?a
      char in ?A..?Z -> rem(char - ?A + shift, 26) + ?A
      true -> char
    end
  end

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&(shift_letter(&1, shift)))
    |> to_string
  end
end

