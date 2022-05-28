defmodule Day05 do
  def part_1(filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&is_orthogonal?/1)
    |> Stream.flat_map(&fill_out_line/1)
    |> Enum.frequencies()
    |> Stream.filter(fn {_key, value} -> value > 1 end)
    |> Enum.count()
  end

  def part_2(filepath) do
    filepath
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Stream.flat_map(&fill_out_line/1)
    |> Enum.frequencies()
    |> Stream.filter(fn {_key, value} -> value > 1 end)
    |> Enum.count()
  end

  def parse_line(line) when is_binary(line) do
    [x1, y1, x2, y2] =
      Regex.run(~r/(\d+),(\d+)\s+->\s+(\d+),(\d+)/, line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)

    [{x1, y1}, {x2, y2}]
  end

  def is_orthogonal?([{x, _}, {x, _}]), do: true
  def is_orthogonal?([{_, y}, {_, y}]), do: true
  def is_orthogonal?([{_, _}, {_, _}]), do: false

  def fill_out_line([{x, start_y}, {x, finish_y}]) do
    for y <- start_y..finish_y, do: {x, y}
  end

  def fill_out_line([{start_x, y}, {finish_x, y}]) do
    for x <- start_x..finish_x, do: {x, y}
  end

  def fill_out_line([{start_x, start_y}, {finish_x, finish_y}]) do
    Enum.zip(start_x..finish_x, start_y..finish_y)
  end
end
