defmodule Crosswords101 do
  @moduledoc """
  https://www.hackerrank.com/challenges/crosswords-101/problem
  [ ] Solved
  """
  # Word representation:
  # %{32 => 'A', 33 => 'B', 34 => 'C' }
  # %{32 => '-', 33 => 'B', 34 => '-' }

  # grid List<Map<int, char>>
  # Is consistent?(grid): Map.merge with no conflicts

  # fit word_template: Map<int, char>, words: List<string> -> grid List<Map<int, char>>

  # fits? word_template Map<int, char>, word : string -> bool

  def fits?(word_template, word) when map_size(word_template) != length(word) do
    false
  end

  def fits?(word_template, word) do
    IO.puts("#{map_size(word_template)} == #{length(word)}")
    true
  end

end
