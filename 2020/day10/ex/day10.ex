defmodule Day10 do
  def part1(input) do
    adapters =
      input
      |> String.splitter("\n", trim: true)
      |> Stream.map(&String.to_integer/1)
      |> Enum.sort()

    distribution =
      Stream.zip(adapters, [0 | adapters])
      |> Stream.map(fn {second, first} -> second - first end)
      |> Enum.frequencies()
      |> Map.update(3, 0, &(&1 + 1))

    distribution[1] * distribution[3]
  end
end
