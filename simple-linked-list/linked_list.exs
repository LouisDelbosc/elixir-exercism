defmodule Node do
  defstruct value: nil, next: nil

  def new, do: %Node{}
  def new(value), do: %Node{value: value}
  def new(value, next), do: %Node{value: value, next: next}

  def next(node, next), do: %{node | next: next}
end

defmodule LinkedList do
  @opaque t :: tuple()
  defstruct head: nil, length: 0

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %LinkedList{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    node = Node.new(elem, list.head)
    new_length = list.length + 1
    %{list | head: node, length: new_length}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    list.length
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    list.head === nil
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    # Your implementation here...
    case list.head do
      nil -> {:error, :empty_list}
      _ -> {:ok, list.head.value}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    # Your implementation here...
    case list.head do
      nil -> {:error, :empty_list}
      _ -> {:ok, %LinkedList{head: list.head.next, length: list.length - 1}}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    case list.head do
      nil -> {:error, :empty_list}
      _ -> {:ok, list.head.value, %LinkedList{head: list.head.next, length: list.length - 1}}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse
    |> Enum.reduce(%LinkedList{}, fn(value, acc) -> LinkedList.push(acc, value) end)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    case list.head do
      nil -> []
      _ -> [list.head.value | to_list %LinkedList{head: list.head.next, length: list.length - 1}]
    end
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list |> to_list |> Enum.reverse |> from_list
  end
end
