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

  def part2(input) do
    nums =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    adapters = Enum.sort([0 | nums], :desc)

    Stream.zip([List.first(adapters) + 3 | adapters], adapters)
    |> Stream.map(fn {first, second} -> first - second end)
    |> Stream.chunk_by(& &1)
    |> Stream.reject(&(3 in &1))
    |> Stream.map(&Enum.count/1)
    |> Stream.map(fn
      4 -> 7
      3 -> 4
      2 -> 2
      1 -> 1
    end)
    |> Enum.reduce(&Kernel.*/2)
  end
end
