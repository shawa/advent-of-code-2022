defmodule Aoc22.Day05.ParsecTest do
  use ExUnit.Case
  alias Aoc22.Day05.Parsec

  @example_rows """
              [J]             [B] [W]
              [T]     [W] [F] [R] [Z]
          [Q] [M]     [J] [R] [W] [H]
      [F] [L] [P]     [R] [N] [Z] [G]
  [F] [M] [S] [Q]     [M] [P] [S] [C]
  [L] [V] [R] [V] [W] [P] [C] [P] [J]
  [M] [Z] [V] [S] [S] [V] [Q] [H] [M]
  [W] [B] [H] [F] [L] [F] [J] [V] [B]
  """

  @example_moves """
  move 3 from 5 to 7
  move 2 from 8 to 9
  move 4 from 3 to 5
  """

  describe "crate/1" do
    test "parses a crate" do
      assert Parsec.crate("[A]") ==
               {:ok, ["A"], "", %{}, {1, 0}, 3}
    end
  end

  describe "blank_space/1" do
    test "parses a blank space" do
      assert Parsec.blank_space("   ") ==
               {:ok, [" "], "", %{}, {1, 0}, 3}
    end
  end

  describe "row/1" do
    test "parses a row" do
      assert Parsec.row("    [F] [L] [P]     [R] [N] [Z] [G]") ==
               {:ok, [" ", "F", "L", "P", " ", "R", "N", "Z", "G"], "", %{}, {1, 0}, 35}
    end
  end

  describe "rows/1" do
    test "parses many rows" do
      assert {:ok, _, "", %{}, {9, 288}, 288} = Parsec.rows(@example_rows)
    end
  end

  describe "move/1" do
    test "parses a move" do
      assert Parsec.move("move 10 from 9 to 1") ==
               {:ok, [amount: '\n', from: '\t', to: [1]], "", %{}, {1, 0}, 19}
    end
  end

  describe "moves/1" do
    test "parses many moves" do
      assert {:ok, _, "", %{}, {4, 57}, 57} = Parsec.moves(@example_moves)
    end
  end

  # @example_input ~S"""
  #             [J]             [B] [W]
  #             [T]     [W] [F] [R] [Z]
  #         [Q] [M]     [J] [R] [W] [H]
  #     [F] [L] [P]     [R] [N] [Z] [G]
  # [F] [M] [S] [Q]     [M] [P] [S] [C]
  # [L] [V] [R] [V] [W] [P] [C] [P] [J]
  # [M] [Z] [V] [S] [S] [V] [Q] [H] [M]
  # [W] [B] [H] [F] [L] [F] [J] [V] [B]
  #  1   2   3   4   5   6   7   8   9
  #  """
  #  ++
  #  " "
  #  ++
  #  """
  # move 3 from 5 to 7
  # move 2 from 8 to 9
  # move 4 from 3 to 5
  # move 2 from 1 to 7
  # move 1 from 3 to 6
  # move 2 from 1 to 7
  # move 1 from 8 to 7
  # move 4 from 2 to 8
  # move 10 from 9 to 1
  # """

  # describe "input/1" do
  #   test "parses a truncated test input" do
  #     assert {:ok, _, "", %{}, {20, 496}, 496} = Parsec.input(@example_input)
  #   end
  # end
end
