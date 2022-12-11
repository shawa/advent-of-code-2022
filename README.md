# Aoc22

Advent of code 2022 solutions in Elixir.

For the sake of fun and avoiding error handling code all over the place, I'm
always assuming that puzzle input is exactly as given, with no corner cases etc.

This basically means there aren't many total functions, and it's very liable to
crash on bad input.

The `day` module can be `used` to dump in some helper functions, as well as to 
auto-define `run/0` which uses the `__MODULE__` to get the input.
