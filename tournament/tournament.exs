defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @result %{
    m: 0,
    w: 0,
    d: 0,
    l: 0,
    p: 0,
  }

  @header {"Team", %{m: "MP", w: "W", d: "D", l: "L", p: "P"}}

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(& String.split(&1, ";"))
    |> Enum.reduce(%{}, &put_line/2)
    |> Enum.sort(&team_bigger?/2)
    |> (&([@header | &1])).()
    |> Enum.map(&line_to_string/1)
    |> Enum.join("\n")
  end

  def put_line([team1, team2, "loss"], acc), do: put_line([team2, team1, "win"], acc)
  def put_line([team1, team2, "win"], acc) do
    acc
    |> put_in([team1], win(acc, team1))
    |> put_in([team2], lose(acc, team2))
  end
  def put_line([team1, team2, "draw"], acc) do
    acc
    |> put_in([team1], draw(acc, team1))
    |> put_in([team2], draw(acc, team2))
  end
  def put_line(_, acc), do: acc

  def win(acc, team) do
    acc
    |> Map.get(team, @result)
    |> update_in([:w], &(&1 + 1))
    |> update_in([:p], &(&1 + 3))
    |> update_in([:m], &(&1 + 1))
  end

  def lose(acc, team) do
    acc
    |> Map.get(team, @result)
    |> update_in([:l], &(&1 + 1))
    |> update_in([:m], &(&1 + 1))
  end

  def draw(acc, team) do
    acc
    |> Map.get(team, @result)
    |> update_in([:d], &(&1 + 1))
    |> update_in([:p], &(&1 + 1))
    |> update_in([:m], &(&1 + 1))
  end

  def team_bigger?({team1, res1}, {team2, res2}) do
    if res1.p == res2.p, do: team1 < team2, else: res1.p > res2.p
  end

  def line_to_string({team, res}) do
    Enum.join([
      String.pad_trailing(team, 30),
      String.pad_leading(to_string(res.m), 2),
      String.pad_leading(to_string(res.w), 2),
      String.pad_leading(to_string(res.d), 2),
      String.pad_leading(to_string(res.l), 2),
      String.pad_leading(to_string(res.p), 2),
    ], " | ")
  end
end
