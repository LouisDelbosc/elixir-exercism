defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @days [monday: 1, tuesday: 2, wednesday: 3, thursday: 4,
         friday: 5, saturday: 6, sunday: 7]
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def day(year, month, weekday, day_index) do
    diff = @days[weekday] - Calendar.ISO.day_of_week(year, month, day_index)
    day_index + Integer.mod(diff, 7)
  end

  def meetup(year, month, weekday, :last) do
    max_day = Calendar.ISO.days_in_month(year, month)
    diff = Calendar.ISO.day_of_week(year, month, max_day) - @days[weekday]
    {year, month, max_day - Integer.mod(diff, 7)}
  end

  def meetup(year, month, weekday, schedule) do
    case schedule do
      :first -> {year, month, day(year, month, weekday, 1)}
      :second -> {year, month, day(year, month, weekday, 8)}
      :third -> {year, month, day(year, month, weekday, 15)}
      :fourth -> {year, month, day(year, month, weekday, 22)}
      :teenth -> {year, month, day(year, month, weekday, 13)}
    end
  end
end
