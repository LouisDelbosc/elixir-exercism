defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @valid_direction [:north, :south, :west, :east]
  @spec create(direction :: atom, position :: { integer, integer }) :: any

  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _) when direction not in @valid_direction do
    { :error, "invalid direction"}
  end
  def create(direction, position = {x, y}) when is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end
  def create(direction, _invalid_position) do
    { :error, "invalid position" }
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, ""), do: robot
  def simulate(robot, "L" <> instructions) do
    directions_mapping = [north: :west, east: :north, south: :east, west: :south]
    new_robot = %{ robot | direction: directions_mapping[direction(robot)]}
    simulate(new_robot, instructions)
  end

  def simulate(robot, "R" <> instructions) do
    directions_mapping = [north: :east, east: :south, south: :west, west: :north]
    new_robot = %{ robot | direction: directions_mapping[direction(robot)]}
    simulate(new_robot, instructions)
  end

  def simulate(robot, "A" <> instructions) do
    {x, y} = position(robot)
    new_robot =
      case direction(robot) do
        :north -> %{ robot | position: {x, y + 1}}
        :east -> %{ robot | position: {x + 1, y}}
        :south -> %{ robot | position: {x, y - 1}}
        :west -> %{ robot | position: {x - 1, y}}
      end
    simulate(new_robot, instructions)
  end

  def simulate(robot, _), do: { :error, "invalid instruction" }

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot) do
    robot[:position]
  end
end
