defmodule Day6 do
  def part1(input) do
    input
    # Split on blank lines
    |> String.splitter("\n\n", trim: true)
    |> Stream.map(&uniq_letter_count/1)
    |> Enum.sum()
  end

  defp uniq_letter_count(string) do
    string
    |> String.splitter("", trim: true)
    |> Stream.reject(&(&1 == "\n"))
    |> Stream.uniq()
    |> Enum.count()
  end

  def part2(input) do
    input
    |> String.splitter("\n\n", trim: true)
    |> Stream.map(&all_letter_count/1)
    |> Enum.sum()
  end

  defp all_letter_count(string) do
    unique_letters =
      string
      |> String.splitter("", trim: true)
      |> Enum.uniq()

    answers = String.split(string, "\n", trim: true)

    unique_letters
    # Filter down to only the letters that are present in every answer
    |> Stream.filter(fn letter -> Enum.all?(answers, &(&1 =~ letter)) end)
    |> Enum.count()
  end
end
