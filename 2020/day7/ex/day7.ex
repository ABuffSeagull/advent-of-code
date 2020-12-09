defmodule Day7 do
  @line_regex ~r/^(?<color>.*?) bags contain (?<contains>.*)\.$/

  @contains_regex ~r/^(?<number>\d+) (?<color>.*?) bags?$/

  def part1(input) do
    rules =
      input
      |> String.splitter("\n", trim: true)
      |> Stream.map(&parse_line_inner_to_outer/1)
      |> Enum.reduce(&merge_maps/2)

    total_colors =
      find_all_colors(rules, "shiny gold")
      |> List.flatten()
      |> Stream.uniq()
      |> Enum.count()

    # since this includes "shiny gold" itself
    total_colors - 1
  end

  def part2(input) do
    rules =
      input
      |> String.splitter("\n", trim: true)
      |> Stream.map(&parse_line_outer_to_inner/1)
      |> Enum.reduce(&merge_maps/2)

    find_all_containing_bags(rules, "shiny gold")
  end

  def parse_line_inner_to_outer(line) do
    [_total, outer_color, contains] = Regex.run(@line_regex, line)

    contains
    |> String.splitter(", ", trim: true)
    |> Stream.map(&parse_contains/1)
    |> Stream.filter(& &1)
    |> Stream.map(fn {_number, color} -> color end)
    |> Map.new(&{&1, [outer_color]})
  end

  def parse_line_outer_to_inner(line) do
    [_total, outer_color, contains] = Regex.run(@line_regex, line)

    %{
      outer_color =>
        contains
        |> String.splitter(", ", trim: true)
        |> Stream.map(&parse_contains/1)
        |> Enum.filter(& &1)
    }
  end

  def parse_contains(contains) do
    case Regex.run(@contains_regex, contains) do
      [_total, number, color] -> {String.to_integer(number), color}
      nil -> nil
    end
  end

  def merge_maps(elem, acc) do
    Map.merge(acc, elem, fn _key, value1, value2 -> value2 ++ value1 end)
  end

  def find_all_colors([], _, total) do
    total
  end

  def find_all_colors(rules, color) do
    case rules[color] do
      nil ->
        color

      colors ->
        [color | Enum.map(colors, &find_all_colors(rules, &1))]
    end
  end

  def find_all_containing_bags(rules, current_color) do
    case rules[current_color] do
      [] ->
        0

      colors ->
        colors
        |> Enum.map(fn {count, color} ->
          count + count * find_all_containing_bags(rules, color)
        end)
        |> Enum.sum()
    end
  end
end
