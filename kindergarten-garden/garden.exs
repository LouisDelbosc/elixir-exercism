defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @plants %{"R" => :radishes, "C" => :clover, "G" => :grass, "V" => :violets}

  def process_line(line_info) do
    line_info
    |> String.graphemes
    |> Enum.map(fn(letter) -> @plants[letter] end)
    |> Enum.chunk_every(2)
  end

  def format_input(info_string) do
    [top_plants, bot_plants] =
      info_string
      |> String.split("\n")
      |> Enum.map(&process_line/1)

    for {[p1, p2], [p3, p4]} <- Enum.zip(top_plants, bot_plants), do: {p1, p2, p3, p4}
  end

  @spec info(String.t(), list) :: map
  def info(info_string) do
    default_student_names = [
      :alice, :bob, :charlie, :david, :eve, :fred, :ginny,
      :harriet, :ileana, :joseph, :kincaid, :larry
    ]
    info(info_string, default_student_names)
  end

  def info(info_string, student_names) do
    plants = format_input(info_string)
    for {name, i} <- student_names |> Enum.sort |> Enum.with_index, into: %{} do
      {name, Enum.at(plants, i, {})}
    end
  end
end
