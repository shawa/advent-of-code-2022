defmodule Aoc22.Day03.Rucksack do
  require Integer

  @type t :: %__MODULE__{left: charlist(), right: charlist()}

  defstruct [:left, :right]

  @spec new(String.t()) :: nil | %__MODULE__{}
  def new(""), do: nil
  def new(<<_::binary-size(1)>>), do: nil

  def new(contents) do
    length = String.length(contents)

    pouch_size = div(length, 2)
    <<left::binary-size(pouch_size), right::binary-size(pouch_size)>> = contents

    %__MODULE__{
      left: String.to_charlist(left),
      right: String.to_charlist(right)
    }
  end

  @spec shared_item(t) :: pos_integer()
  def shared_item(%__MODULE__{left: left, right: right}) do
    intersection =
      MapSet.intersection(
        MapSet.new(left),
        MapSet.new(right)
      )

    Enum.at(intersection, 0)
  end

  @spec to_mapset(t()) :: MapSet.t()
  def to_mapset(%__MODULE__{left: left, right: right}), do: MapSet.new(left ++ right)

  @spec priority_for(pos_integer()) :: integer()
  def priority_for(char) when ?a <= char and char <= ?z, do: char - ?a + 1
  def priority_for(char) when ?A <= char and char <= ?Z, do: char - ?A + 27
end
