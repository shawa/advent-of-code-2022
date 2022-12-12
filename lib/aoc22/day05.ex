defmodule Aoc22.Day05 do
  alias Aoc22.Day05.Parsec

  @type crate :: String.t()

  @type row :: {
          crate,
          crate,
          crate,
          crate,
          crate,
          crate,
          crate,
          crate,
          crate
        }

  def part_1(input) do
    input
    |> Parsec.input()
    |> IO.inspect(printable_limit: :infinity, limit: :infinity)
  end

  def part_2(_input) do
    1
  end

  def run() do
    part_1(input())
  end

  def input() do
    Aoc22.input_for(__MODULE__, 1)
  end
end
