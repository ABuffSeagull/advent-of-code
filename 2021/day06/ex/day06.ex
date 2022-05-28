defmodule Day06 do
  def part_1(filename) when is_binary(filename), do: run(filename, 80)
  def part_2(filename) when is_binary(filename), do: run(filename, 256)

  def run(filename, count) when is_binary(filename) and is_integer(count) do
    counts =
      filename
      |> File.read!()
      |> String.trim()
      |> String.splitter(",", trim: true)
      |> Stream.map(&String.to_integer/1)
      |> Enum.frequencies()

    fish_counts = Enum.map(0..8, &Map.get(counts, &1, 0))

    Enum.reduce(1..count, fish_counts, fn _, [new | rest] ->
      List.update_at(rest ++ [new], 6, &(&1 + new))
    end)
    |> Enum.sum()
  end
end
