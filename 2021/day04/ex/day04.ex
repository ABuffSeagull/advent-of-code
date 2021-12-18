defmodule Day4 do
  def part1 do
    [nums | boards] =
      "../input.txt"
      |> File.read!()
      |> String.split("\n\n", trim: true)

    nums =
      nums
      |> String.splitter(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards = Enum.map(boards, &parse_board/1)

    {num, winning_board} =
      Enum.reduce_while(nums, boards, fn num, boards ->
        new_boards = Enum.map(boards, &update_board(&1, num))

        case Enum.find(new_boards, &winning_board?/1) do
          nil -> {:cont, new_boards}
          board -> {:halt, {num, board}}
        end
      end)

    score = score_board(winning_board)

    score * num
  end

  def parse_board(board) do
    board
    |> String.splitter("\n", trim: true)
    |> Stream.with_index()
    |> Stream.map(fn {line, row} ->
      line
      |> String.splitter(" ", trim: true)
      |> Stream.with_index()
      |> Stream.map(fn {num_string, column} ->
        {String.to_integer(num_string), {{row, column}, false}}
      end)
      |> Map.new()
    end)
    |> Enum.reduce(&Map.merge/2)
  end

  def winning_board?(board) do
    full_rows =
      board
      |> Enum.group_by(
        fn {_num, {{row, _col}, _marked}} -> row end,
        fn {_num, {_coord, marked}} -> marked end
      )
      |> Enum.filter(fn {_key, marks} -> Enum.all?(marks) end)

    full_cols =
      board
      |> Enum.group_by(
        fn {_num, {{_row, col}, _marked}} -> col end,
        fn {_num, {_coord, marked}} -> marked end
      )
      |> Enum.filter(fn {_key, marks} -> Enum.all?(marks) end)

    Enum.count(full_rows) > 0 || Enum.count(full_cols) > 0
  end

  def update_board(board, num) do
    if Map.has_key?(board, num) do
      Map.update!(board, num, fn {coord, _} -> {coord, true} end)
    else
      board
    end
  end

  def score_board(board) do
    board
    |> Stream.filter(fn {_, {_coord, marked}} -> !marked end)
    |> Stream.map(fn {num, _} -> num end)
    |> Enum.sum()
  end

  def part2 do
    [nums | boards] =
      "../input.txt"
      |> File.read!()
      |> String.split("\n\n", trim: true)

    nums =
      nums
      |> String.splitter(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards = Enum.map(boards, &parse_board/1)

    {_, [{num, last_board} | _]} =
      Enum.reduce(nums, {boards, []}, fn num, {incomplete_boards, complete_boards} ->
        new_boards = Enum.map(incomplete_boards, &update_board(&1, num))

        case Enum.filter(new_boards, &winning_board?/1) do
          [] ->
            {new_boards, complete_boards}

          boards ->
            {new_boards -- boards, Enum.map(boards, &{num, &1}) ++ complete_boards}
        end
      end)

    score_board(last_board) * num
  end
end
