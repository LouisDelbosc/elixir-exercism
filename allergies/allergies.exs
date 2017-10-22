defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  * eggs (1)
  * peanuts (2)
  * shellfish (4)
  * strawberries (8)
  * tomatoes (16)
  * chocolate (32)
  * pollen (64)
  * cats (128)
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags
    |> Integer.digits(2)
    |> allergies(~w(cats pollen chocolate tomatoes strawberries shellfish peanuts eggs))
  end

  def allergies([], _), do: []
  def allergies(flags, list) do
    case {flags, list} do
      { [_|t], list } when length(flags) > length(list) -> allergies(t, list)
      { flags, [_|t] } when length(flags) < length(list) -> allergies(flags, t)
      { [1|t1], [h|t2] } -> [ h | allergies(t1, t2)]
      { [0|t1], [_|t2] } -> allergies(t1, t2)
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
