defmodule Day5 do
  def part1(input) do
    input
    |> Stream.map(&get_seat_id/1)
    |> Enum.max()
  end

  def part2(input) do
    occupied_seats =
      Stream.map(input, &get_seat_id/1)
      |> Enum.sort()

    # Find the first occupied seat where the next seat is unoccupied,
    # as that will be our seat.
    {empty_seat, _} =
      Stream.zip(occupied_seats, Stream.drop(occupied_seats, 1))
      |> Enum.find(fn {seat, next_seat} -> seat + 1 != next_seat end)

    empty_seat + 1
  end

  def get_seat_id(directions) do
    # Split into row and column directions
    {rows, columns} =
      directions
      |> String.graphemes()
      |> Enum.split(7)

    # Basically we're building a number in binary
    # First we make a descending list of powers of 2, ending with 1.
    # Then we zip it with the letters of the directions
    # We then filter it down to only the "back" directions, as they add to the
    # final row number
    # Then sum them up to the get the final number.
    # Simple!
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
