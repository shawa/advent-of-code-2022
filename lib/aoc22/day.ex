defmodule Aoc22.Day do
  defmacro __using__(_opts) do
    quote do
      def input() do
        Aoc22.input_lines_for(__MODULE__)
      end

      def run() do
        [
          part_1: part_1(input()),
          part_2: part_2(input())
        ]
      end

      defdelegate parse_int!(string), to: Aoc22
    end
  end
end
