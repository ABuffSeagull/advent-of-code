defmodule Day1 do
  def part1(nums) when is_list(nums) do
    nums_set = MapSet.new(nums)

    found = Enum.find(nums_set, fn num -> (2020 - num) in nums_set end)

    found * (2020 - found)
  end

  def part2(nums) when is_list(nums) do
    nums_set = MapSet.new(nums)

    {num_a, num_b} =
      for(first <- nums_set, second <- nums_set, do: {first, second})
      |> Enum.find(fn {num_a, num_b} -> (2020 - num_a - num_b) in nums_set end)

    num_a * num_b * (2020 - num_a - num_b)
  end
end

[part, input_file] = System.argv()

nums =
  input_file
  |> File.read!()
  |> String.splitter("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

apply(Day1, String.to_atom(part), [nums])
|> IO.puts()
