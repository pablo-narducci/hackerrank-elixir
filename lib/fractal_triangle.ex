defmodule FractalTriangle do
  def main do
    IO.read(:stdio, :line)
    |> String.split([" ", "\n"])
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&String.to_integer(&1))
    #|> List.first
    |> triangle
    |> Enum.reverse
    |> Enum.each(
        &IO.puts(Enum.reduce(&1, "", fn x, acum -> "#{x}#{acum}" end)
        |> String.trim))

  end

  def triangle(n) do
    iter_triangle(0,0,[],[],n)
  end

  def iter_triangle(row, _column, lines, _acum, _n) when row == 32 do
    lines
  end

  def iter_triangle(row, column, lines, acum, n) when column == 63 do
    iter_triangle(row + 1, 0, [acum|lines], [], n)
  end

  def iter_triangle(row, column, lines, acum, n) do
    iter_triangle(row, column + 1, lines, [should_print(row, column, n) | acum], n)
  end

  def should_print(row, column, _n) do
    if (column >= 31 - row) and (column <= 31 + row), do: "1", else: "_"
  end

end
