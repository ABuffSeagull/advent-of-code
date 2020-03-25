defmodule Day2 do
  def part1(input) do
    input
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> compute()
    |> List.first()
  end

  def compute(input, position \\ 0) do
    case Enum.at(input, position) do
      1 -> compute(change_list(input, position, &+/2), position + 4)
      2 -> compute(change_list(input, position, &*/2), position + 4)
      99 -> input
    end
  end

  def change_list(input, position, operation) do
    [first_pos, second_pos, save_pos] = Enum.slice(input, position + 1, 3)

    new_value = operation.(Enum.at(input, first_pos), Enum.at(input, second_pos))

    List.replace_at(input, save_pos, new_value)
  end

  def part2(input) do
    possible_inputs = for noun <- 1..99, verb <- 1..99, do: [noun, verb]

    [noun, verb] =
      Enum.find(possible_inputs, fn [noun, verb] ->
        19_690_720 ==
          input
          |> List.replace_at(1, noun)
          |> List.replace_at(2, verb)
          |> compute()
          |> List.first()
      end)

    100 * noun + verb
  end
end

System.argv()
|> File.read!()
|> String.trim()
|> String.split(",")
|> Enum.map(&String.to_integer/1)
|> Day2.part2()
|> IO.puts()
