defmodule Day12 do
  @facing ~w[north east south west]a

  def part1(input) do
    {{x, y}, _facing} =
      input
      |> String.splitter("\n", trim: true)
      |> Stream.map(&parse_line/1)
      |> Enum.reduce({{0, 0}, :east}, &follow_directions/2)

    abs(x) + abs(y)
  end

  def parse_line(line) when is_binary(line) do
    {op, num} = String.split_at(line, 1)

    op =
      case op do
        "F" -> :forward
        "R" -> :turn_right
        "L" -> :turn_left
        "N" -> :north
        "E" -> :east
        "S" -> :south
        "W" -> :west
      end

    {op, String.to_integer(num)}
  end

  def follow_directions(instruction, acc) do
    {{x, y}, facing} = acc

    case instruction do
      {:north, amount} ->
        {{x, y + amount}, facing}

      {:south, amount} ->
        {{x, y - amount}, facing}

      {:east, amount} ->
        {{x + amount, y}, facing}

      {:west, amount} ->
        {{x - amount, y}, facing}

      {:turn_right, amount} ->
        turn_steps = div(amount, 90)

        new_facing =
          @facing
          |> Stream.cycle()
          |> Stream.drop_while(&(&1 != facing))
          |> Enum.fetch!(turn_steps)

        {{x, y}, new_facing}

      {:turn_left, amount} ->
        turn_steps = 4 - div(amount, 90)

        new_facing =
          @facing
          |> Stream.cycle()
          |> Stream.drop_while(&(&1 != facing))
          |> Enum.fetch!(turn_steps)

        {{x, y}, new_facing}

      {:forward, amount} ->
        follow_directions({facing, amount}, acc)
    end
  end

  def part2(input) do
    instructions =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&parse_line/1)

    ship = {0, 0}
    waypoint = {10, 1}

    {{x, y}, _} = Enum.reduce(instructions, {ship, waypoint}, &follow_waypoint_instructions/2)

    abs(x) + abs(y)
  end

  def follow_waypoint_instructions(instruction, {ship, waypoint}) do
    {waypoint_x, waypoint_y} = waypoint

    case instruction do
      {:north, amount} ->
        {ship, {waypoint_x, waypoint_y + amount}}

      {:south, amount} ->
        {ship, {waypoint_x, waypoint_y - amount}}

      {:east, amount} ->
        {ship, {waypoint_x + amount, waypoint_y}}

      {:west, amount} ->
        {ship, {waypoint_x - amount, waypoint_y}}

      {:turn_right, amount} ->
        steps =
          amount
          |> div(90)
          |> rem(4)

        case steps do
          0 ->
            {ship, waypoint}

          1 ->
            {ship, {waypoint_y, -waypoint_x}}

          2 ->
            {ship, {-waypoint_x, -waypoint_y}}

          3 ->
            {ship, {-waypoint_y, waypoint_x}}
        end

      {:turn_left, amount} ->
        follow_waypoint_instructions({:turn_right, 360 - amount}, {ship, waypoint})

      {:forward, amount} ->
        {ship_x, ship_y} = ship
        {{ship_x + waypoint_x * amount, ship_y + waypoint_y * amount}, waypoint}
    end
  end
end
