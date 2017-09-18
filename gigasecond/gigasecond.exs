defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from(datetime = {{year, month, day}, {hours, minutes, seconds}}) do
    with {:ok, start} <- NaiveDateTime.from_erl(datetime) do
      start
      |> NaiveDateTime.add(1_000_000_000, :seconds)
      |> NaiveDateTime.to_erl
  end
end
