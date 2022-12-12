defmodule Aoc22.Day05.Parsec do
  import NimbleParsec

  blank_space = ignore(string(" ")) |> string(" ") |> ignore(string(" "))

  crate =
    empty()
    |> ignore(string("["))
    |> ascii_string([?A..?Z], 1)
    |> ignore(string("]"))

  entry = choice([blank_space, crate])

  defparsec(:entry, entry)

  row = repeat(entry |> ignore(string(" "))) |> concat(entry)

  defparsec(
    :row,
    row
  )

  rows = repeat(row |> ignore(string("\n")) |> tag(:row))

  defparsec(
    :rows,
    rows
  )

  separator =
    ignore(string(" 1   2   3   4   5   6   7   8   9 ")) |> ignore(ascii_string([?\n], 2))

  defparsec(:separator, separator)

  move =
    empty()
    |> ignore(string("move "))
    |> concat(integer(min: 1) |> unwrap_and_tag(:amount))
    |> ignore(string(" from "))
    |> concat(integer(min: 1) |> unwrap_and_tag(:from))
    |> ignore(string(" to "))
    |> concat(integer(min: 1) |> unwrap_and_tag(:to))
    |> tag(:move)

  defparsec(:move, move)

  moves = repeat(move |> ignore(string("\n"))) |> tag(:moves)
  defparsec(:moves, moves)

  defparsec(
    :input,
    empty() |> concat(rows |> tag(:rows)) |> concat(separator) |> concat(moves)
  )

  defparsec(:blank_space, blank_space)
  defparsec(:crate, crate)
end
