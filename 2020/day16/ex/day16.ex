defmodule Day16 do
  @rule_regex ~r/\w+: (?<range_1>[\d-]+) or (?<range_2>[\d-]+)/

  def part1(input) do
    [rules, _ticket, other_tickets] = String.split(input, "\n\n", trim: true)

    rules = parse_rules(rules)

    other_tickets
    |> String.splitter(["\n", ","], trim: true)
    |> Stream.drop(1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.filter(fn num -> Enum.all?(rules, &(num not in &1)) end)
    |> Enum.sum()
  end

  def parse_rules(string) do
    string
    |> String.splitter("\n", trim: true)
    |> Stream.map(&Regex.named_captures(@rule_regex, &1))
    |> Enum.map(&parse_captured/1)
    |> List.flatten()
  end

  def parse_captured(captures) do
    captures
    |> Stream.map(fn {_name, value} -> String.split(value, "-") end)
    |> Enum.map(fn [start, end_] ->
      Range.new(String.to_integer(start), String.to_integer(end_))
    end)
  end
end
