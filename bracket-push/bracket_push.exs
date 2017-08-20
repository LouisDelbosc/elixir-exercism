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
  def push_bracket([ bracket | rest ], stack) when bracket in ["{", "[", "("] do
    push_bracket(rest, [ bracket | stack ])
  end

  def push_bracket([ bracket | _ ], []) when bracket in ["}", "]", ")"], do: false
  def push_bracket([ bracket | rest ], [h|t]) when bracket in ["}", "]", ")"] do
    if closing_bracket?(h, bracket), do: push_bracket(rest, t), else: false
  end

  def push_bracket([ _ | rest ], stack), do: push_bracket(rest, stack)

  def closing_bracket?("{", "}"), do: true
  def closing_bracket?("[", "]"), do: true
  def closing_bracket?("(", ")"), do: true
  def closing_bracket?(_, _), do: false
end
