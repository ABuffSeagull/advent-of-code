defmodule Day3 do
  def part1(input) when is_binary(input) do
    houses =
      input
      |> String.graphemes()
      |> Enum.scan({0, 0}, &move/2)

    [{0, 0} | houses]
    |> Stream.uniq()
    |> Enum.count()
  end

  def part2(input) do
    path = String.graphemes(input)

    santa_path = Stream.take_every(path, 2)

    robo_santa_path =
      path
      |> Stream.drop(1)
      |> Stream.take_every(2)

    santa_houses = [{0, 0} | Enum.scan(santa_path, {0, 0}, &move/2)]
    robo_santa_houses = [{0, 0} | Enum.scan(robo_santa_path, {0, 0}, &move/2)]

    (santa_houses ++ robo_santa_houses)
    |> Stream.uniq()
    |> Enum.count()
  end

  def move(direction, coord) do
    case {direction, coord} do
      {"^", {x, y}} -> {x, y + 1}
      {">", {x, y}} -> {x + 1, y}
      {"v", {x, y}} -> {x, y - 1}
      {"<", {x, y}} -> {x - 1, y}
    end
  end
end
