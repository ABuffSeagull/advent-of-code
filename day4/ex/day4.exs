defmodule Day4 do
  def part1 do
    172_930..683_082
    |> Stream.map(&Integer.to_string/1)
    |> Stream.map(&String.graphemes/1)
    |> Stream.filter(&(&1 == Enum.sort(&1)))
    # check for adjacent matching digits
    |> Stream.filter(fn num_list ->
      num_list
      |> Enum.zip(tl(num_list))
      |> Enum.any?(&(elem(&1, 0) == elem(&1, 1)))
    end)
  end

  def part2 do
    part1()
    |> Stream.filter(fn num_list ->
      case num_list
           |> MapSet.new()
           |> Enum.map(fn num -> {num, Enum.count(num_list, &(num == &1))} end)
           |> Enum.find(fn {_, count} -> count == 2 end) do
        nil ->
          false

        {double_num, _} ->
          [first, second] =
            num_list
            |> Enum.with_index()
            |> Enum.filter(fn {num, _} -> num == double_num end)
            |> Enum.map(&elem(&1, 1))

          second - first == 1
      end
    end)
  end
end
