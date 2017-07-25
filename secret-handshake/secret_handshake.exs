import Bitwise

defmodule SecretHandshake do

  @commands %{
    0b1 => "wink",
    0b10 => "double blink",
    0b100 => "close your eyes",
    0b1000 => "jump"
  }

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  def reverse(list, code) do
    if (code &&& 0b10000) != 0 do
      Enum.reverse list
    else
      list
    end
  end

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    in_list? = fn(x) -> (x &&& code) != 0 end
    (for {a, b} <- @commands, in_list?.(a), do: b)
    |> reverse(code)
  end
end

