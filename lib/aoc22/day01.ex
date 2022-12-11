defmodule Aoc22.Day01 do
  use Aoc22.Day

  @spec part_1(Stream.t()) :: integer()
  def part_1(input) do
    input
    |> totals()
    |> Enum.at(0)
  end

  @spec part_2(Stream.t()) :: integer()
  def part_2(input) do
    input
    |> totals()
    |> Enum.take(3)
    |> Enum.sum()
  end

  @spec totals(Stream.t()) :: [integer]
  def totals(input) do
    input
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
    |> Enum.map(fn chunk -> Enum.map(chunk, &parse_int!/1) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort_by(&-/1)
  end
end
