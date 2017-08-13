defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  def encode_letter([]), do: ""
  def encode_letter([h|t]) do
    case t do
      [] -> [h]
      _ -> "#{length(t)+1}#{[h]}"
    end
  end

  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> to_charlist
    |> Enum.chunk_by(&(&1))
    |> Enum.map(&encode_letter/1)
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(""), do: ""
  def decode(string) do
    case Integer.parse(string) do
      {count, rest} ->
        {letter, rest} = String.split_at(rest, 1)
        String.duplicate(letter, count) <> decode(rest)
      :error ->
        {letter, rest} = String.split_at(string, 1)
        letter <> decode(rest)
    end
  end
end
