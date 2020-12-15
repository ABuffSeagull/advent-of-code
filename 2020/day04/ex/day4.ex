defmodule Day4 do
  @required_fields ~w[byr iyr eyr hgt hcl ecl pid]

  @hair_regex ~r/^#[0-9a-f]{6}$/

  @valid_eye_colors ~w[amb blu brn gry grn hzl oth]

  @passport_id_regex ~r/^\d{9}$/

  @spec part1(String.t()) :: non_neg_integer()
  def part1(input) do
    input
    |> parse_input()
    |> Stream.filter(&has_all_fields?/1)
    |> Enum.count()
  end

  @spec part2(String.t()) :: non_neg_integer()
  def part2(input) do
    input
    |> parse_input()
    |> Stream.filter(&has_all_fields?/1)
    |> Stream.filter(&is_valid?/1)
    |> Enum.count()
  end

  @spec has_all_fields?(map) :: boolean()
  def has_all_fields?(passport_map) do
    Enum.all?(@required_fields, &Map.has_key?(passport_map, &1))
  end

  @spec parse_input(String.t()) :: [map(), ...]
  def parse_input(input) when is_binary(input) do
    input
    |> String.splitter("\n\n", trim: true)
    |> Enum.map(&parse_passport/1)
  end

  @spec parse_passport(String.t()) :: map()
  def parse_passport(passport) do
    passport
    |> String.splitter([" ", "\n"], trim: true)
    |> Stream.map(&String.split(&1, ":", trim: true))
    |> Map.new(fn [key, value] -> {key, value} end)
  end

  @spec is_valid?(map()) :: boolean()
  def is_valid?(passport_map) do
    [
      &valid_birth_year?/1,
      &valid_issue_year?/1,
      &valid_expiration_year?/1,
      &valid_height?/1,
      &valid_hair_color?/1,
      &valid_eye_color?/1,
      &valid_passport_id?/1
    ]
    |> Enum.all?(& &1.(passport_map))
  end

  @spec valid_birth_year?(map()) :: boolean()
  def valid_birth_year?(passport),
    do: String.to_integer(passport["byr"]) in 1920..2002

  @spec valid_issue_year?(map()) :: boolean()
  def valid_issue_year?(passport),
    do: String.to_integer(passport["iyr"]) in 2010..2020

  @spec valid_expiration_year?(map()) :: boolean()
  def valid_expiration_year?(passport),
    do: String.to_integer(passport["eyr"]) in 2020..2030

  @spec valid_height?(map()) :: boolean()
  def valid_height?(passport) do
    case Integer.parse(passport["hgt"]) do
      {num, "cm"} -> num in 150..193
      {num, "in"} -> num in 59..76
      _ -> false
    end
  end

  @spec valid_hair_color?(map()) :: boolean()
  def valid_hair_color?(passport),
    do: passport["hcl"] =~ @hair_regex

  @spec valid_eye_color?(map()) :: boolean()
  def valid_eye_color?(passport),
    do: passport["ecl"] in @valid_eye_colors

  @spec valid_passport_id?(map()) :: boolean()
  def valid_passport_id?(passport),
    do: passport["pid"] =~ @passport_id_regex
end
