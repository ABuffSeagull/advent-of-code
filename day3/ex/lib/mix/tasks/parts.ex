defmodule Mix.Tasks.Day3.Part1 do
  use Mix.Task

  @impl Mix.Task
  def run([filepath]) do
    filepath
    |> File.read!()
    |> String.trim()
    |> String.split()
    |> Day3.part_1()
    |> IO.puts()
  end
end

defmodule Mix.Tasks.Day3.Part2 do
  use Mix.Task

  @impl Mix.Task
  def run([filepath]) do
    filepath
    |> File.read!()
    |> String.trim()
    |> String.split()
    |> Day3.part_2()
    |> IO.puts()
  end
end
