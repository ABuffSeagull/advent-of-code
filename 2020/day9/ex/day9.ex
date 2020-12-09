defmodule Day9 do
  def part1(input, preamble_length) do
    numbers =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    bad_slice =
      numbers
      |> Stream.iterate(&tl/1)
      |> Stream.map(&Enum.take(&1, preamble_length + 1))
      |> Enum.find(&not_valid_slice?(&1))

    List.last(bad_slice)
  end

  def not_valid_slice?(slice) do
    [num_to_check | rest] = Enum.reverse(slice)

    not Enum.any?(rest, fn other_num ->
      (num_to_check - other_num) in rest
    end)
  end

  def part2(input, preamble_length) do
    bad_number = part1(input, preamble_length)

    numbers =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    {min, max} =
      numbers
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
