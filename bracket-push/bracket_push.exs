defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes
    |> push_bracket([])
  end

  def push_bracket([], stack), do: stack === []
  def push_bracket(["(" | rest ], stack), do: push_bracket(rest, [")" | stack])
  def push_bracket(["{" | rest ], stack), do: push_bracket(rest, ["}" | stack])
  def push_bracket(["[" | rest ], stack), do: push_bracket(rest, ["]" | stack])
  def push_bracket([closing | rest], [closing | tail]), do: push_bracket(rest, tail)
  def push_bracket([first | _], _) when first in ~w(\} \] \)), do: false
  def push_bracket([_ | rest], stack), do: push_bracket(rest, stack)
end
