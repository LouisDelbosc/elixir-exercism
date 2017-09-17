defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(fn line -> process(line) end)
    |> replace_md
  end

  defp process(line = "#" <> rest), do: parse_header(line)
  defp process("* " <> rest), do: "<li>#{rest}</li>"
  defp process(line), do: "<p>#{line}</p>"

  defp parse_header(header) do
    [ h | t ] = String.split(header, " ", parts: 2)
    "<h#{String.length(h)}>#{t}</h#{String.length(h)}>"
  end

  defp replace_md(md) do
    md
    |> String.replace(~r/__(.*?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*?)_/, "<em>\\1</em>")
    |> String.replace(~r/<li>.*<\/li>/, "<ul>\\0</ul>")
  end
end
