defmodule Day3 do
  @type direction() :: :R | :L | :U | :D
  @type coordinate() :: {integer(), integer()}

  @spec part_1([String.t()]) :: pos_integer()
  def part_1(wires) do
    wires
    |> Enum.map(&parse_wire/1)
    |> find_intersections()
    |> Enum.map(&distance/1)
    |> Enum.min()
  end

  @spec parse_wire(String.t()) :: [coordinate()]
  defp parse_wire(wire) do
    wire
    |> String.split(",")
    |> Enum.map(fn dir_length ->
      {direction, length} = String.split_at(dir_length, 1)
      {String.to_atom(direction), String.to_integer(length)}
    end)
    # Initially start at zero
    |> Enum.reduce([{0, 0}], &wire_to_coords/2)
    |> Enum.reverse()
    # Remove zero coord, since it's not counted
    |> tl()
  end

  # We make the list of coordinates in reverse, since it's easier to work with
  @spec wire_to_coords({direction(), pos_integer()}, [coordinate()]) :: [coordinate()]
  defp wire_to_coords({direction, length}, [{last_x, last_y} | _] = coords) do
    Enum.map(
      length..1,
      case direction do
        :R -> &{last_x + &1, last_y}
        :L -> &{last_x - &1, last_y}
        :U -> &{last_x, last_y + &1}
        :D -> &{last_x, last_y - &1}
      end
    ) ++ coords
  end

  @spec distance(coordinate()) :: pos_integer()
  defp distance({x, y}), do: abs(x) + abs(y)

  @spec find_intersections([coordinate()]) :: MapSet.t(coordinate())
  defp find_intersections(wires) do
    wires
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
  end

  @spec part_2([String.t()]) :: pos_integer()
  def part_2(wires) do
    wires = Enum.map(wires, &parse_wire/1)
    intersections = find_intersections(wires)

    wires
    |> Enum.map(fn wire ->
      Enum.map(intersections, fn intersection ->
        Enum.find_index(wire, &(intersection == &1)) + 1
      end)
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.min()
  end
end
