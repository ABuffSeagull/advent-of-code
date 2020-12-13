defmodule Day13 do
  def part1(input) do
    [timestamp, busses] = String.split(input, "\n", trim: true)

    timestamp = String.to_integer(timestamp)

    {id, wait_time} =
      busses
      |> String.splitter(",", trim: true)
      |> Stream.reject(&(&1 == "x"))
      |> Stream.map(&String.to_integer/1)
      |> Stream.map(&{&1, rem(timestamp, &1)})
      |> Stream.map(fn {id, remainder} -> {id, id - remainder} end)
      |> Enum.min_by(fn {_, wait_time} -> wait_time end)

    id * wait_time
  end
end
