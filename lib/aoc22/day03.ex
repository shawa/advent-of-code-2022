defmodule Aoc22.Day03 do
  alias Inspect.Stream
  alias Aoc22.Day03.Rucksack

  @spec part_1(Stream.t()) :: pos_integer()
  def part_1(input) do
    input
    |> Enum.map(&Rucksack.new/1)
    |> Enum.map(&Rucksack.shared_item/1)
    |> Enum.map(&Rucksack.priority_for/1)
    |> Enum.sum()
  end

  @spec part_2(Stream.t()) :: pos_integer()
  def part_2(input) do
    input
    |> Enum.map(&Rucksack.new/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&common_item/1)
    |> Enum.map(&Rucksack.priority_for/1)
    |> Enum.sum()
  end

  @spec common_item([Rucksack.t()]) :: pos_integer()
  def common_item(chunk) do
    base =
      MapSet.union(
        MapSet.new(?a..?z),
        MapSet.new(?A..?Z)
      )

    chunk
    |> Enum.map(&Rucksack.to_mapset/1)
    |> Enum.reduce(base, &MapSet.intersection/2)
    |> Enum.at(0)
  end

  def run do
    [
      part_1: part_1(input()),
      part_2: part_2(input())
    ]
  end

  def input do
    Aoc22.input_lines_for(__MODULE__, 1)
  end
end
