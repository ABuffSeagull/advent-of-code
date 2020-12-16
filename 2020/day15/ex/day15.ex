defmodule Day15 do
  def part1(input), do: run_game(input, 2020)
  def part2(input), do: run_game(input, 30_000_000)

  def run_game(input, turns) do
    start_nums =
      input
      |> String.splitter(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    start_map =
      start_nums
      |> Stream.with_index()
      |> Map.new(fn {num, index} -> {num, index + 1} end)

    {last_num, _} =
      (length(start_nums) + 1)..turns
      |> Enum.reduce({List.last(start_nums), start_map}, fn turn,
                                                            {last_num, last_mentioned_map} ->
        num_to_produce =
          case Map.fetch(last_mentioned_map, last_num) do
            {:ok, last_mentioned} -> turn - 1 - last_mentioned
            :error -> 0
          end

        {num_to_produce, Map.put(last_mentioned_map, last_num, turn - 1)}
      end)

    last_num
  end
end
