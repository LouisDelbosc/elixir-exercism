defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([ _ | t ]), do: 1 + count(t)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([], acc), do: acc
  def reverse([ h | t ], acc), do: reverse(t, [ h | acc ])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([ h | t ], f), do: [ f.(h) | map(t, f) ]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([ h | t ], f) do
    if f.(h), do: [ h | filter(t, f) ], else: filter(t, f)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([ h | t ], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([ h | t ], b), do: [ h | append(t, b) ]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([b]), do: b
  def concat([ hl | tl ]), do: append(hl, concat(tl))
end
