defmodule Day9 do
  def part1(input, preamble_length) do
    numbers =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    bad_index =
      preamble_length..(length(numbers) - 1)
      |> Enum.find(&valid_number?(numbers, preamble_length, &1))

    Enum.at(numbers, bad_index)
  end

  def valid_number?(numbers, preamble_length, index) do
    current_num = Enum.at(numbers, index)

    current_slice = Enum.slice(numbers, index - preamble_length, preamble_length)

    not Enum.any?(current_slice, fn number ->
      (current_num - number) in current_slice
    end)
  end

  def part2(input, preamble_length) do
    bad_number = part1(input, preamble_length)

    {min, max} =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Stream.iterate(&tl/1)
      |> Stream.map(&subtract_to_non_positive(&1, bad_number))
      |> Enum.find_value(fn
        {0, nums} -> nums
        _ -> nil
      end)
      |> Enum.min_max()

    min + max
  end

  def subtract_to_non_positive(num_list, bad_number) do
    Enum.reduce_while(num_list, {bad_number, []}, fn num, {acc, nums} ->
      new_acc = acc - num

      if new_acc <= 0 do
        {:halt, {new_acc, nums}}
      else
        {:cont, {new_acc, [num | nums]}}
      end
    end)
  end
end
