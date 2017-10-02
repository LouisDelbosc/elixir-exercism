defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    numbers = get_numbers(question)
    operations = get_operations(question)
    compose_answer(numbers, operations)
  end

  def compose_answer(_, []), do: raise ArgumentError
  def compose_answer([h|t], operations) do
    operations
    |> Enum.zip(t)
    |> Enum.reduce(h, fn {ops, number}, acc -> ops.(acc, number) end)
  end

  def get_numbers(question) do
    ~r/-{0,1}\d+/
    |> Regex.scan(question)
    |> List.flatten
    |> Enum.map(&String.to_integer/1)
  end
  def get_operations(question) do
    ~r/plus|multiplied|minus|divided/
    |> Regex.scan(question)
    |> List.flatten
    |> Enum.map(&map_operation/1)
  end

  def map_operation("plus"), do: &Kernel.+/2
  def map_operation("minus"), do: &Kernel.-/2
  def map_operation("multiplied"), do: &Kernel.*/2
  def map_operation("divided"), do: &Kernel.//2

end
