defmodule Day3 do
  def part1 do
    bit_arrays =
      "../input.txt"
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(fn line ->
        line
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
      end)
      |> transpose()

    common_digits = Enum.map(bit_arrays, &most_frequent_digit/1)

    uncommon_digits = Enum.map(common_digits, &Bitwise.bxor(1, &1))

    Integer.undigits(common_digits, 2) * Integer.undigits(uncommon_digits, 2)
  end

  def transpose([[] | _]), do: []

  def transpose([head | _] = list) when is_list(list) and is_list(head) do
    heads = Enum.map(list, &hd/1)
    tails = Enum.map(list, &tl/1)

    [heads | transpose(tails)]
  end

  def most_frequent_digit(list) do
    frequencies = Enum.frequencies(list)

    {num, _} = Enum.max_by(frequencies, fn {_num, count} -> count end)
    num
  end

  def part2 do
    bit_arrays =
      "../input.txt"
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(fn line ->
        line
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
      end)

    oxy_gen_rating =
      Stream.iterate(0, &(&1 + 1))
      |> Enum.reduce_while(bit_arrays, filter_bit(&Kernel.>=/2))
      |> Integer.undigits(2)

    co2_scrub_rating =
      Stream.iterate(0, &(&1 + 1))
      |> Enum.reduce_while(bit_arrays, filter_bit(&Kernel.</2))
      |> Integer.undigits(2)

		oxy_gen_rating * co2_scrub_rating
  end

  def filter_bit(filter_fn) do
    fn
      _, [num] ->
        {:halt, num}

      bit_index, bit_arrays ->
        indexed_bits = Enum.map(bit_arrays, &Enum.at(&1, bit_index))

        frequencies = Enum.frequencies(indexed_bits)
        one_count = Map.get(frequencies, 1, 0)
        zero_count = Map.get(frequencies, 0, 0)

        common_digit = if filter_fn.(one_count, zero_count), do: 1, else: 0

        {:cont, Enum.filter(bit_arrays, fn num -> Enum.at(num, bit_index) == common_digit end)}
    end
  end
end
