defmodule Day2 do
  @line_regex ~r/^(?<first_number>\d+)-(?<second_number>\d+) (?<letter>[a-z]): (?<password>[a-z]+)$/

  def part1(lines) do
    lines
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&validate_password_range/1)
    |> Enum.count()
  end

  def part2(lines) do
    lines
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&validate_password_xor/1)
    |> Enum.count()
  end

  def parse_line(line) when is_binary(line) do
    %{
      "first_number" => first_number,
      "second_number" => second_number,
      "letter" => letter,
      "password" => password
    } = Regex.named_captures(@line_regex, line)

    %{
      first_number: String.to_integer(first_number),
      second_number: String.to_integer(second_number),
      letter: letter,
      password: password
    }
  end

  def validate_password_range(password_map) when is_map(password_map) do
    letter_count =
      password_map.password
      |> String.graphemes()
      |> Enum.count(&(&1 == password_map.letter))

    letter_count in Range.new(password_map.first_number, password_map.second_number)
  end

  def validate_password_xor(password_map) when is_map(password_map) do
    password_chars = String.graphemes(password_map.password)

    letter_at_first =
      Enum.at(password_chars, password_map.first_number - 1) == password_map.letter

    letter_at_second =
      Enum.at(password_chars, password_map.second_number - 1) == password_map.letter

    (letter_at_first or letter_at_second) and not (letter_at_first and letter_at_second)
  end
end
