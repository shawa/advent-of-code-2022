defmodule Aoc22.Day04 do
  use Aoc22.Day

  @type assignment :: {Range.t(), Range.t()}

  @line_regex ~r/(?<first_left>\d+)-(?<last_left>\d+),(?<first_right>\d+)-(?<last_right>\d+)/

  @spec parse(String.t()) :: assignment()
  def parse(line) do
    captures = Regex.named_captures(@line_regex, line)

    %{
      "first_left" => first_left,
      "last_left" => last_left,
      "first_right" => first_right,
      "last_right" => last_right
    } = captures

    {
      parse_int!(first_left)..parse_int!(last_left),
      parse_int!(first_right)..parse_int!(last_right)
    }
  end

  @spec fully_contains?(Range.t(), Range.t()) :: boolean()
  def fully_contains?(
        %Range{first: first_left, last: last_left, step: 1},
        %Range{first: first_right, last: last_right, step: 1}
      ) do
    first_right >= first_left and last_right <= last_left
  end

  @spec has_fully_contained_range(assignment) :: boolean()
  def has_fully_contained_range({left, right}) do
    fully_contains?(left, right) or fully_contains?(right, left)
  end

  @spec has_overlap?({Range.t(), Range.t()}) :: boolean()
  def has_overlap?({left, right}) do
    not Range.disjoint?(left, right)
  end

  @spec part_1(Stream.t()) :: pos_integer()
  def part_1(input) do
    input
    |> Stream.map(&parse/1)
    |> Enum.count(&has_fully_contained_range/1)
  end

  @spec part_2(Stream.t()) :: pos_integer()
  def part_2(input) do
    input
    |> Stream.map(&parse/1)
    |> Enum.count(&has_overlap?/1)
  end
end
