defmodule Day4 do
  def part1 do
    172_930..683_082
    |> Stream.map(&Integer.digits/1)
    |> Stream.filter(&(&1 == Enum.sort(&1)))
    # check for adjacent matching digits
    |> Stream.filter(fn [_ | tail_list] = num_list ->
      num_list
      |> Stream.zip(tail_list)
      |> Enum.any?(fn {first_digit, second_digit} -> first_digit == second_digit end)
    end)
  end

  def part2 do
    part1()
    |> Stream.filter(fn num_list ->
      case num_list
           |> MapSet.new()
           |> Stream.map(fn num -> {num, Enum.count(num_list, &(num == &1))} end)
           |> Enum.find(fn {_, count} -> count == 2 end) do
        nil ->
          false

        {double_num, _} ->
          [first, second] =
            num_list
            |> Stream.with_index()
            |> Stream.filter(fn {num, _} -> num == double_num end)
            |> Enum.map(&elem(&1, 1))

          second - first == 1
      end
    end)
  end
end
