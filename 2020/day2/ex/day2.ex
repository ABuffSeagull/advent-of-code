defmodule Day2 do
  @line_regex ~r/^(?<lower_amount>\d+)-(?<upper_amount>\d+) (?<letter>[a-z]): (?<password>[a-z]+)$/

  def part1(lines) do
    lines
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&validate_password/1)
    |> Enum.count()
  end

  def parse_line(line) when is_binary(line) do
    %{
      "lower_amount" => lower,
      "upper_amount" => upper,
      "letter" => letter,
      "password" => password
    } = Regex.named_captures(@line_regex, line)

    %{
      lower: String.to_integer(lower),
      upper: String.to_integer(upper),
      letter: letter,
      password: password
    }
  end

  def validate_password(password_map) when is_map(password_map) do
    letter_count =
      password_map.password
      |> String.graphemes()
      |> Enum.count(&(&1 == password_map.letter))

    letter_count in Range.new(password_map.lower, password_map.upper)
  end
end
