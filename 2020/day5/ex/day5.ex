defmodule Day5 do
  def part1(input) do
    input
    |> Stream.map(&get_seat_id/1)
    |> Enum.max()
  end

  def get_seat_id(directions) do
    # Split into row and column directions
    {rows, columns} =
      directions
      |> String.graphemes()
      |> Enum.split(7)

    row_num =
      Range.new(length(rows) - 1, 0)
      |> Stream.map(&:math.pow(2, &1))
      |> Stream.map(&:erlang.floor/1)
      |> Stream.zip(rows)
      |> Stream.filter(fn {_exponent, instruction} -> instruction == "B" end)
      |> Stream.map(fn {exponent, _instruction} -> exponent end)
      |> Enum.sum()

    column_number =
      Range.new(length(columns) - 1, 0)
      |> Stream.map(&:math.pow(2, &1))
      |> Stream.map(&:erlang.floor/1)
      |> Stream.zip(columns)
      |> Stream.filter(fn {_exponent, instruction} -> instruction == "R" end)
      |> Stream.map(fn {exponent, _instruction} -> exponent end)
      |> Enum.sum()

    row_num * 8 + column_number
  end
end
