defmodule Day2 do
  def part1(file) do
    {forwards, depth_changes} =
      File.stream!(file)
      |> Stream.map(&parse_line/1)
      |> Enum.split_with(fn {motion, _} -> motion == :forward end)

    horizontal_change =
      forwards
      |> Stream.map(fn {_, change} -> change end)
      |> Enum.sum()

    final_depth =
      depth_changes
      |> Stream.map(fn
        {:down, change} -> change
        {:up, change} -> -change
      end)
      |> Enum.sum()

    horizontal_change * final_depth
  end

  def part2(file) do
    commands =
      File.stream!(file)
      |> Enum.map(&parse_line/1)

    horizontal_change =
      commands
      |> Stream.map(fn
        {:forward, num} -> num
        {_, _} -> 0
      end)
      |> Enum.sum()

    {_aim, depth_change} =
      commands
      |> Enum.reduce({0, 0}, fn
        {:down, x}, {aim, depth} -> {aim + x, depth}
        {:up, x}, {aim, depth} -> {aim - x, depth}
        {:forward, x}, {aim, depth} -> {aim, depth + aim * x}
      end)

    horizontal_change * depth_change
  end

  def parse_line("forward" <> rest), do: {:forward, parse_num(rest)}
  def parse_line("up" <> rest), do: {:up, parse_num(rest)}
  def parse_line("down" <> rest), do: {:down, parse_num(rest)}

  defp parse_num(str) do
    str
    |> String.trim()
    |> String.to_integer()
  end
end
