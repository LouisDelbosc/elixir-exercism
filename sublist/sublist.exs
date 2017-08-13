defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a === b, do: :equal
  def compare(a, b) when length(a) > length(b) do
    if sublist?(a, b), do: :superlist, else: :unequal
  end
  def compare(a, b) when length(a) < length(b) do
    if sublist?(b, a), do: :sublist, else: :unequal
  end
  def compare(_, _), do: :unequal

  def sublist?(a, b) when length(b) > length(a), do: false
  def sublist?(a, b) do
    [_|t] = a
    cond do
      Enum.slice(a, 0, length(b)) === b -> true
      true -> sublist?(t, b)
    end
  end
end
