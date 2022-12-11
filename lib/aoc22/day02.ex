defmodule Aoc22.Day02 do
  use Aoc22.Day

  @type outcome :: :lose | :draw | :win
  @type move :: :rock | :paper | :scissors
  @type turn :: {move, move}
  @type strategy_guide :: [turn]

  @spec score_for(turn) :: non_neg_integer()
  def score_for({_, us} = turn) do
    outcome_score =
      turn
      |> outcome_for()
      |> outcome_score_for()

    outcome_score + move_score_for(us)
  end

  @spec outcome_for(turn) :: outcome()
  def outcome_for({same, same}), do: :draw

  def outcome_for({them, us}) do
    if move_to_lose(them) == us do
      :lose
    else
      :win
    end
  end

  @spec move_to_lose(move) :: move()
  def move_to_lose(:rock), do: :scissors
  def move_to_lose(:paper), do: :rock
  def move_to_lose(:scissors), do: :paper

  @spec move_to_win(move) :: move()
  def move_to_win(:rock), do: :paper
  def move_to_win(:paper), do: :scissors
  def move_to_win(:scissors), do: :rock

  @spec parse_naive_line(String.t()) :: turn()
  def parse_naive_line(<<theirs::binary-size(1), " ", ours::binary-size(1)>>) do
    {parse_theirs(theirs), parse_ours(ours)}
  end

  @spec parse_strat_line(String.t()) :: {move, outcome}
  def parse_strat_line(<<theirs::binary-size(1), " ", ours::binary-size(1)>>) do
    {parse_theirs(theirs), parse_needed_outcome(ours)}
  end

  @spec turn_for({move, outcome}) :: turn
  def turn_for({move, :draw}), do: {move, move}
  def turn_for({move, :win}), do: {move, move_to_win(move)}
  def turn_for({move, :lose}), do: {move, move_to_lose(move)}

  @spec parse_theirs(String.t()) :: move()
  def parse_theirs("A"), do: :rock
  def parse_theirs("B"), do: :paper
  def parse_theirs("C"), do: :scissors

  @spec parse_ours(String.t()) :: move()
  def parse_ours("X"), do: :rock
  def parse_ours("Y"), do: :paper
  def parse_ours("Z"), do: :scissors

  @spec parse_needed_outcome(String.t()) :: outcome()
  def parse_needed_outcome("X"), do: :lose
  def parse_needed_outcome("Y"), do: :draw
  def parse_needed_outcome("Z"), do: :win

  @spec outcome_score_for(outcome) :: 0 | 3 | 6
  defp outcome_score_for(:lose), do: 0
  defp outcome_score_for(:draw), do: 3
  defp outcome_score_for(:win), do: 6

  @spec move_score_for(move) :: 1 | 2 | 3
  def move_score_for(:rock), do: 1
  def move_score_for(:paper), do: 2
  def move_score_for(:scissors), do: 3

  @spec part_1(Stream.t()) :: non_neg_integer()
  def part_1(input) do
    input
    |> Stream.map(&parse_naive_line/1)
    |> Stream.map(&score_for/1)
    |> Enum.sum()
  end

  @spec part_2(Stream.t()) :: non_neg_integer()
  def part_2(input) do
    input
    |> Enum.map(&parse_strat_line/1)
    |> Enum.map(&turn_for/1)
    |> Enum.map(&score_for/1)
    |> Enum.sum()
  end
end
