defmodule Day7 do
  @line_regex ~r/^(?<color>.*?) bags contain (?<contains>.*)\.$/

  @contains_regex ~r/^\d+ (?<color>.*?) bags?$/

  def part1(input) do
    rules =
      input
      |> String.splitter("\n", trim: true)
      |> Stream.map(&parse_line/1)
      |> Enum.reduce(&merge_maps/2)

    find_all_colors(["shiny gold"], rules, [])
    |> Stream.uniq()
    |> Enum.count()
  end

  def parse_line(line) when is_binary(line) do
    [_total, outer_color, contains] = Regex.run(@line_regex, line)

    contains
    |> String.splitter(", ", trim: true)
    |> Stream.map(&parse_contains/1)
    |> Stream.filter(& &1)
    |> Map.new(&{&1, [outer_color]})
  end

  def parse_contains(contains) when is_binary(contains) do
    case Regex.run(@contains_regex, contains) do
      [_total, color] -> color
      nil -> nil
    end
  end

  def merge_maps(elem, acc) do
    Map.merge(acc, elem, fn _key, value1, value2 -> value2 ++ value1 end)
  end

  def find_all_colors([], _, total) do
    total
  end

  def find_all_colors([color | rest], rules, total) do
    case rules[color] do
      nil ->
        find_all_colors(rest, rules, total)

      colors ->
        find_all_colors(colors ++ rest, rules, colors ++ total)
    end
  end
end
