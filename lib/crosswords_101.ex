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
    Enum.zip([Map.values(word_template), word])
    |> Enum.all?(fn {k, v} -> if k == "-", do: true, else: k == v end)
  end

  def fit(word_template, word) do
    Enum.zip([Map.keys(word_template), word])
    |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, v) end)
  end

  def complete({done, remaining}, words) when length(words) == 1 do
    [word] = words
    [rem] = remaining
    if (fits?(rem, word)) do
      [fit(rem, word) | done]
    else
      []
    end
  end

  def complete({done, remaining}, words) do
    IO.puts("Done: #{length(done)}. Remaining: #{length(remaining)}. Words #{length(words)}")
    [current|rest] = remaining
    words
    |> Enum.filter(fn x -> fits?(current, x) end)
    |> Enum.map(fn x -> complete({[fit(current, x) | done], rest}, List.delete(words, x)) end)
    |> List.first
  end

end
