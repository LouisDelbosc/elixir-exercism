defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from(datetime = {date_tuple, time_tuple}) do
    datetime
    |> NaiveDateTime.from_erl
    |> (fn {:ok, datetime} -> datetime end).()
    |> NaiveDateTime.add(1_000_000_000, :second)
    |> NaiveDateTime.to_erl
  end
end
