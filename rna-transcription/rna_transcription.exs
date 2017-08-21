defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @dna_mapping [
    {?G, ?C},
    {?C, ?G},
    {?T, ?A},
    {?A, ?U},
 ]

  @spec to_rna([char]) :: [char]
  def to_rna(''), do: ''
  for {dna, rna} <- @dna_mapping do
    def to_rna([ unquote(dna) | t ]), do: [ unquote(rna) | to_rna(t) ]
  end
end
