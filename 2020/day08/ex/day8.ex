defmodule Day8 do
  @type instruction :: {:acc | :jmp | :nop, integer}

  @spec part1(String.t()) :: integer()
  def part1(input) when is_binary(input) do
    program =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&parse_instruction/1)

    {_, accumulator} = run_program(program)
    accumulator
  end

  @spec part2(String.t()) :: integer()
  def part2(input) when is_binary(input) do
    program =
      input
      |> String.splitter("\n", trim: true)
      |> Enum.map(&parse_instruction/1)

    {:ok, final_acc} =
      program
      |> Stream.with_index()
      |> Stream.map(fn {_, index} ->
        List.update_at(program, index, fn
          {:acc, num} -> {:acc, num}
          {:jmp, num} -> {:nop, num}
          {:nop, num} -> {:jmp, num}
        end)
      end)
      |> Stream.reject(&(&1 == program))
      |> Stream.map(&run_program/1)
      |> Enum.find(fn {status, _acc} -> status == :ok end)

    final_acc
  end

  @spec parse_instruction(String.t()) :: instruction()
  def parse_instruction(line) when is_binary(line) do
    [instruction, number] = String.split(line, " ")
    {String.to_atom(instruction), String.to_integer(number)}
  end

  @spec run_program([instruction(), ...], MapSet.t(), non_neg_integer(), integer()) ::
          {:ok | :error, integer()}
  def run_program(
        program,
        visited_addresses \\ MapSet.new(),
        current_address \\ 0,
        accumulator \\ 0
      ) do
    unless current_address in visited_addresses do
      added_address = MapSet.put(visited_addresses, current_address)

      case Enum.at(program, current_address, :done) do
        {:acc, num} ->
          run_program(program, added_address, current_address + 1, accumulator + num)

        {:jmp, num} ->
          run_program(program, added_address, current_address + num, accumulator)

        {:nop, _} ->
          run_program(program, added_address, current_address + 1, accumulator)

        :done ->
          {:ok, accumulator}
      end
    else
      {:error, accumulator}
    end
  end
end
