defmodule Day9 do
  def part1(input, preamble_length) do
    numbers =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    bad_index =
      0..(length(numbers) - 1)
      |> Stream.drop(preamble_length)
      |> Enum.find(&valid_number?(numbers, preamble_length, &1))

    Enum.at(numbers, bad_index)
  end

  def valid_number?(numbers, preamble_length, index) do
    current_num = Enum.at(numbers, index)

    current_slice =
      numbers
      |> Enum.slice(index - preamble_length, preamble_length)

    not Enum.any?(current_slice, fn number ->
      (current_num - number) in current_slice
    end)
  end
end
