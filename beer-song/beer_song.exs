defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  def bottles(0), do: "no more bottles"
  def bottles(1), do: "1 bottle"
  def bottles(-1), do: bottles(99)
  def bottles(number), do: "#{number} bottles"

  def take_down(0), do: "Go to the store and buy some more"
  def take_down(1), do: "Take it down and pass it around"
  def take_down(_), do: "Take one down and pass it around"

  @spec verse(integer) :: String.t
  def verse(number) do
    bottle_count = bottles(number)
    """
    #{String.capitalize(bottle_count)} of beer on the wall, #{bottle_count} of beer.
    #{take_down(number)}, #{bottles(number - 1)} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics, do: lyrics(99..0)
  def lyrics(range) do
    (for number <- range, do: verse(number))
    |> Enum.join("\n")
  end
end
