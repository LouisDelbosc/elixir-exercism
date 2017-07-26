defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  def shift_letter(binary_letter, shift) do
    cond do
      (binary_letter >= ?a) and (binary_letter <= ?z) ->
        rem(binary_letter - ?a + shift, 26) + ?a

      (binary_letter >= ?A) and (binary_letter <= ?Z) ->
        rem(binary_letter - ?A + shift, 26) + ?A

      true ->
        binary_letter
    end
  end

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    partial_shift = fn(x) -> shift_letter(x, shift) end
    to_charlist(text)
    |> Enum.map(partial_shift)
    |> to_string
  end
end

