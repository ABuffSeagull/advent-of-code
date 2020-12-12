defmodule Day11 do
  def part1(input) do
    grid = parse_input(input)

    grid
    |> update_grid(&update_cell_part_1/1)
    |> Enum.count(fn {_, value} -> value == :occupied end)
  end

  def part2(input) do
    grid = parse_input(input)

    grid
    |> update_grid(&update_cell_part_2/1)
    |> Enum.count(fn {_, cell} -> cell == :occupied end)
  end

  def update_grid(grid, update_function) do
    update_cell = update_function.(grid)

    new_grid =
      grid
      |> Stream.map(update_cell)
      |> Map.new()

    unless new_grid == grid do
      update_grid(new_grid, update_function)
    else
      new_grid
    end
  end

  def update_cell_part_1(grid) do
    fn {coord, cell} ->
      {row, column} = coord

      adjacent_coords =
        for x <- [-1, 0, 1], y <- [-1, 0, 1], !(x == 0 and y == 0) do
          {row + y, column + x}
        end

      occupied_seats =
        adjacent_coords
        |> Stream.map(&grid[&1])
        |> Enum.count(&(&1 == :occupied))

      cond do
        cell == :empty and occupied_seats == 0 ->
          {coord, :occupied}

        cell == :occupied and occupied_seats >= 4 ->
          {coord, :empty}

        true ->
          {coord, cell}
      end
    end
  end

  def update_cell_part_2(grid) do
    fn {coord, cell} ->
      first_possible_seats =
        for x <- [-1, 0, 1], y <- [-1, 0, 1], !(x == 0 and y == 0) do
          coord
          |> Stream.iterate(fn {row, column} -> {row + y, column + x} end)
          |> Stream.drop(1)
          |> Stream.map(&grid[&1])
          |> Enum.find(&(&1 != :floor))
        end

      occupied_seats = Enum.count(first_possible_seats, &(&1 == :occupied))

      cond do
        cell == :empty and occupied_seats == 0 ->
          {coord, :occupied}

        cell == :occupied and occupied_seats >= 5 ->
          {coord, :empty}

        true ->
          {coord, cell}
      end
    end
  end

  def parse_input(input) do
    input_stream = String.splitter(input, "", trim: true)

    row_length = Enum.find_index(input_stream, &(&1 == "\n"))

    input_stream
    |> Stream.reject(&(&1 == "\n"))
    |> Stream.map(fn
      "L" -> :empty
      "." -> :floor
      "#" -> :occupied
    end)
    |> Stream.with_index()
    |> Map.new(fn {row, index} -> {{div(index, row_length), rem(index, row_length)}, row} end)
  end

  def print_map(map, row_length) do
    rows =
      for row <- 0..row_length do
        row =
          for column <- 0..row_length do
            case map[{row, column}] do
              :occupied -> "#"
              :empty -> "L"
              :floor -> "."
            end
          end

        Enum.join(row)
      end

    rows
    |> Enum.join("\n")
    |> IO.puts()
  end

  def time_part_2 do
    input = File.read!("../input.txt")

    total_time =
      1..10
      |> Stream.map(fn _ ->
        start_time = Time.utc_now()
        part2(input)
        end_time = Time.utc_now()

        Time.diff(end_time, start_time, :millisecond)
        |> IO.inspect(label: "time")
      end)
      |> Enum.sum()

    total_time / 10
  end
end
