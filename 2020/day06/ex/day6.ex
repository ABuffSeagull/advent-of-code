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

  def all_letter_count(string) do
    string
    # Split to indivdual answers
    |> String.splitter("\n", trim: true)
    # Split each answer on letters
    |> Stream.map(&String.splitter(&1, "", trim: true))
    # Turn each answer into a Set
    |> Stream.map(&MapSet.new/1)
    # Intersect all sets to find the common letters
    |> Enum.reduce(&MapSet.intersection/2)
    |> Enum.count()
  end
end
