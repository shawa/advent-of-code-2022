defmodule Aoc22 do
  @day_re ~r/Elixir.Aoc22.Day(?<day>\d{2})/

  @all_days [Aoc22.Day01, Aoc22.Day02, Aoc22.Day03, Aoc22.Day04]

  @spec input_for(module(), 1 | 2) :: String.t()
  def input_for(module, part) do
    filepath = input_filepath_for(module, part)
    File.read!(filepath)
  end

  @spec input_lines_for(module, 1 | 2) :: Stream.t()
  def input_lines_for(module, part \\ 1) do
    filepath = input_filepath_for(module, part)

    filepath
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end

  defp input_filepath_for(module, part) do
    day = day_for(module)
    base_path = :code.priv_dir(:aoc_22)
    day_part = "day_#{day}"
    part_part = "part_#{part}.txt"

    Path.join([base_path, "input", day_part, part_part])
  end

  defp day_for(module) do
    module_string = Atom.to_string(module)
    captures = Regex.named_captures(@day_re, module_string)
    captures["day"]
  end

  @spec parse_int!(String.t()) :: integer()
  def parse_int!(input) do
    {int, ""} = Integer.parse(input)
    int
  end

  @spec run :: [{module(), keyword()}]
  def run do
    Enum.map(@all_days, &{&1, &1.run()})
  end
end
