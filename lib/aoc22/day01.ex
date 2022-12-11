defmodule Aoc22.Day01 do
  @spec part_1(String.t()) :: integer()
  def part_1(input) do
    input
    |> totals()
    |> Enum.at(0)
  end

  def part_2(input) do
    input
    |> totals()
    |> Enum.take(3)
    |> IO.inspect()
    |> Enum.sum()
  end

  def totals(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn
      "" -> nil
      text -> Aoc22.parse_int!(text)
    end)
    |> Enum.chunk_by(&is_nil/1)
    |> Enum.reject(&(&1 == [nil]))
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort_by(&-/1)
  end

  def run() do
    input = Aoc22.input_for(__MODULE__, 1)
    part_1_soln = part_1(input)
    part_2_soln = part_2(input)

    IO.puts("""
    part 1: #{part_1_soln}

    part 2: #{part_2_soln}
    """)
  end
end
