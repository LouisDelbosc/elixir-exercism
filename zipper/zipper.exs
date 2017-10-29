defmodule BinTree do
  import Inspect.Algebra
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat ["(", to_doc(v, opts),
            ":", (if l, do: to_doc(l, opts), else: ""),
            ":", (if r, do: to_doc(r, opts), else: ""),
            ")"]
  end
end

defmodule Zipper do
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    {bt, bt, []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree({_focus, bt, _trail}) do
    bt
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value({focus, _bt, _trail}) do
    focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left({%{left: nil}, _, _}), do: nil
  def left({focus, bt, trail}) do
    {focus.left, bt, [ :left | trail ]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right({%{right: nil}, _, _}), do: nil
  def right({focus, bt, trail}) do
    {focus.right, bt, [ :right | trail ]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up({_, _, []}), do: nil
  def up({_, bt, [_h]}), do: {bt, bt, []}
  def up({_focus, bt, [_h|t]}) do
    t
    |> trail_to_keys
    |> (&{ get_in(bt, &1), bt, t }).()
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z = {focus, _, _}, v) do
    new_focus = %{focus | value: v}
    set_zipper(new_focus, z)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z = {focus, _, _}, l) do
    new_focus = %{focus | left: l}
    set_zipper(new_focus, z)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z = {focus, _, _}, r) do
    new_focus = %{focus | right: r}
    set_zipper(new_focus, z)
  end

  defp trail_to_keys(trail), do: trail |> Enum.reverse |> Enum.map(&Access.key/1)
  def set_zipper(new_focus, {_, _bt, []}), do: {new_focus, new_focus, []}
  def set_zipper(new_focus, {_, bt, trail}) do
    trail
    |> trail_to_keys
    |> (&{ new_focus, put_in(bt, &1, new_focus), trail }).()
  end
end
