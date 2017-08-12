defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    message "#{sound(number, 3)}#{sound(number,5)}#{sound(number,7)}", number
  end

  defp sound(number, 3) when rem(number, 3) == 0, do: "Pling"
  defp sound(number, 5) when rem(number, 5) == 0, do: "Plang"
  defp sound(number, 7) when rem(number, 7) == 0, do: "Plong"
  defp sound(_, _), do: ""

  defp message("", number), do: "#{number}"
  defp message(string, _), do: string

end
