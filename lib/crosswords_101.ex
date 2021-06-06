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

  def fit(word_template, word, remaining, done) do
    current = fit(word_template, word)

    remaining = remaining
    |> Enum.map(&update_word_template(&1, current))

    {[current|done], remaining}
  end

  def update_word_template(existing, current) do
    existing
    |> Enum.reduce(%{},fn {k, v}, acc -> Map.put(acc, k, (if Map.has_key?(current, k), do: current[k], else: v)) end)
  end

  def complete({done, remaining}, words) when length(words) == 1 do
    [word] = words
    [rem] = remaining
    if (fits?(rem, word)) do
      fit(rem, word, [], done)
    else
      {[],[]}
    end
  end

  def complete({done, remaining}, words) do
    [current|rest] = remaining

    words
    |> Enum.filter(fn x -> fits?(current, x) end)
    |> Enum.map(fn x -> complete(fit(current, x, rest, done), List.delete(words, x)) end)
    |> List.first
  end

  def main_complete(remaining, words) do
    complete({[], remaining}, words)
    |> first_or_nil
  end

  def first_or_nil(nil), do: []

  def first_or_nil({done, _}), do: done

end
