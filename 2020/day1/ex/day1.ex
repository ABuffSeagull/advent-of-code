defmodule Day1 do
  def part1(nums) when is_list(nums) do
    nums_set = MapSet.new(nums)

    found = Enum.find(nums_set, fn num -> (2020 - num) in nums_set end)

    found * (2020 - found)
  end

  def part2(nums) when is_list(nums) do
    nums_set = MapSet.new(nums)

    {num_a, num_b} =
      nums_set
      |> Stream.flat_map(fn num -> Enum.map(nums_set, &{num, &1}) end)
      |> Enum.find(fn {num_a, num_b} -> (2020 - num_a - num_b) in nums_set end)

    num_a * num_b * (2020 - num_a - num_b)
  end
end

System.argv()
|> List.first()
|> File.read!()
|> String.splitter("\n", trim: true)
|> Enum.map(&String.to_integer/1)
|> Day1.part1()
