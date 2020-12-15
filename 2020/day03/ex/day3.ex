defmodule Day3 do
  @type map :: [[boolean(), ...], ...]
  def part1(input) do
    map = parse_map(input)
    path = run_path(map, 3, 1)

    Enum.count(path, & &1)
  end

  def part2(input) do
    map = parse_map(input)

    right_paths = Enum.map([1, 3, 5, 7], &run_path(map, &1, 1))

    down_path = run_path(map, 1, 2)

    [down_path | right_paths]
    |> Enum.map(fn path -> Enum.count(path, & &1) end)
    |> Enum.reduce(&Kernel.*/2)
  end

  @doc """
  Parses the input into a list of Streams
  """
  @spec parse_map(String.t()) :: map()
  def parse_map(input) when is_binary(input) do
    input
    |> String.splitter("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  @doc """
  Parses a line into an infinite, repeating Stream of booleans,
  indicating whether there's a tree or not in that space
  """
  @spec parse_line(String.t()) :: [boolean(), ...]
  def parse_line(line) when is_binary(line) do
    line
    |> String.graphemes()
    |> Stream.map(fn
      "." -> false
      "#" -> true
    end)
    |> Stream.cycle()
  end

  @doc """
  Run a path along a map, given certain ratios for how you move along
  the map. For instance, with a `right_ratio` of 2, and `down_ratio` of 1,
  we move 2 right and 1 down at every step. Returns a list of booleans for
  whether there was a tree in each step of the path.
  """
  @spec run_path(map(), pos_integer(), pos_integer()) :: [boolean(), ...]
  def run_path(map, right_ratio, down_ratio) do
    ratiod_length = div(length(map), down_ratio)

    for index <- 0..(ratiod_length - 1) do
      map
      |> Enum.at(index * down_ratio)
      |> Enum.at(index * right_ratio)
    end
  end
end
