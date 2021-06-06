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
    remaining = :lists.sort(remaining)

    complete({[], remaining}, words)
    |> first_or_nil
  end

  def first_or_nil(nil), do: []

  def first_or_nil({done, _}), do: done

  def read_line(0, accum) do
    accum
  end

  def read_line(n, accum) do
    curr = IO.read(:stdio, :line)
    |> String.trim("\n")
    |> String.graphemes

    read_line(n-1, [curr|accum])
  end

  def parse_names(names) do
    names
    |> String.trim("\n")
    |> String.split(";")
    |> Enum.map(&String.graphemes(&1))
  end

  def main do
    lines = read_line(10,[])
    |> Enum.reverse

    words = IO.read(:stdio, :line)
    |> parse_names

    word_templates = to_grid(lines)
    |> to_word_templates

    main_complete(word_templates, words)
    |> to_print
    |> Enum.each(
        &IO.puts(Enum.reduce(&1, "", fn x, acum -> "#{x}#{acum}" end)
        |> String.reverse |> String.trim))
  end

  def to_grid(lines) do
    Enum.zip(0..9, lines)
    |> Enum.map(fn {x, y} -> to_map(x, 0, y, %{}) end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc) end)
  end

  def to_map(_, _, [], accum) do
    accum
  end

  def to_map(row, col, [curr_char | rest], accum) when curr_char == "+" do
    to_map(row, col + 1, rest, accum)
  end

  def to_map(row, col, [curr_char | rest], accum) when curr_char == "-" do
    to_map(row, col + 1, rest, Map.put(accum, row * 10 + col,"-"))
  end

  def to_word_templates(all_spots) do
    rows = 0..9
    |> Enum.map(&search_row(all_spots, &1, 0, %{}, []))
    |> Enum.reduce([], fn x, acc -> x ++ acc end)

    cols = 0..9
    |> Enum.map(&search_column(all_spots, 0, &1, %{}, []))
    |> Enum.reduce([], fn x, acc -> x ++ acc end)

    rows ++ cols
  end

  def search_row(_,_,10, current, accum) do
    if current != %{} do
      [current | accum]
    else
      accum
    end
  end

  def search_row(all_spots, row, col, current, accum) do
    key = row * 10 + col
    if Map.has_key?(all_spots, key) do
      search_row(all_spots, row, col + 1, Map.put(current, key, "-"), accum)
    else
      if map_size(current) > 1 do
        search_row(all_spots, row, col + 1, %{}, [current | accum])
      else
        search_row(all_spots, row, col + 1, %{}, accum)
      end
    end
  end

  def search_column(_,10,_, current, accum) do
    if current != %{} do
      [current | accum]
    else
      accum
    end
  end

  def search_column(all_spots, row, col, current, accum) do
    key = row * 10 + col
    if Map.has_key?(all_spots, key) do
      search_column(all_spots, row + 1, col, Map.put(current, key, "-"), accum)
    else
      if map_size(current) > 1 do
        search_column(all_spots, row + 1, col, %{}, [current | accum])
      else
        search_column(all_spots, row + 1, col, %{}, accum)
      end
    end
  end

  def to_print(grid) do
    0..9
    |> Enum.map(&print_row(&1, 0, grid, []))
    |> Enum.map(&Enum.reverse(&1))
  end

  def print_row(_, 10, _, accum) do
    accum
  end

  def print_row(row, column, grid, accum) do
    curr = get_template_spot(row, column, grid)
    print_row(row, column + 1, grid, [curr|accum])
  end

  def get_template_spot(row, column, grid) do
    key = row * 10 + column
    grid
    |> Enum.filter(&Map.has_key?(&1, key))
    |> List.first
    |> (fn x -> if x == nil, do: "+", else: x[key] end).()
  end

end
