defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(), do: %Queens{black: {7, 3}, white: {0, 3}}
  def new(white, white), do: raise ArgumentError, message: "foo"
  def new(white, black) do
    %Queens{black: black, white: white}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    7..0
    |> Enum.reduce([], fn row_index, acc -> [display_row(row_index, queens)|acc] end)
    |> Enum.join("\n")
  end

  defp display_row(i, queens) do
    template = List.duplicate("_", 8)
    case {white, black} = {queens.white, queens.black} do
      {{a, b}, _} when a == i -> template |> List.replace_at(b, "W") |> Enum.join(" ")
      {_, {a, b}} when a == i -> template |> List.replace_at(b, "B") |> Enum.join(" ")
      _ -> template |> Enum.join(" ")
    end
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{white: {r, _}, black: {r, _}}), do: true
  def can_attack?(%Queens{white: {_, c}, black: {_, c}}), do: true
  def can_attack?(%Queens{white: {r1, c1}, black: {r2, c2}}) when r1 - r2 == c1 - c2, do: true
  def can_attack?(%Queens{white: {r1, c1}, black: {r2, c2}}) when r1 + c1 == c2 + r2, do: true
  def can_attack?(_), do: false
end
