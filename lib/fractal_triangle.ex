defmodule FractalTriangle do

  @height 32
  @width @height * 2 - 1

  def main do

    IO.read(:stdio, :line)
    |> String.trim
    |> String.to_integer
    |> triangle
    |> Enum.reverse
    |> Enum.each(
        &IO.puts(Enum.reduce(&1, "", fn x, acum -> "#{x}#{acum}" end)
        |> String.trim))

  end

  def triangle(n) do
    iter_triangle(0,0,[],[],split_triangle({{@height - 1, 0}, {0, @height - 1}, {@width - 1, @height - 1}}, n))
  end

  def iter_triangle(row, _column, lines, _acum, _n) when row == @height do
    lines
  end

  def iter_triangle(row, column, lines, acum, triangles) when column == @width do
    iter_triangle(row + 1, 0, [acum|lines], [], triangles)
  end

  def iter_triangle(row, column, lines, acum, triangles) do
    iter_triangle(row, column + 1, lines, [should_print(row, column, triangles) | acum], triangles)
  end

  def should_print(row, column, triangles) do
    if Enum.any?(triangles, &inside_triangle?(&1, column, row)), do: "1", else: "_"
  end

  @doc """
     a
    b c
  """
  def inside_triangle?({{_, _}, {bx, by}, {cx, _}}, x, y) do
      x - bx >= by - y and y <= by and cx - x >= by - y
  end

  def split_triangle(triangle, 0) do
    [triangle]
  end

  def split_triangle({{ax, ay}, {bx, by}, {cx, cy}}, n) do
    Enum.concat([
      split_triangle({ {ax, ay}, {ax - div(ax - bx, 2), ay + div(by - ay, 2)}, {ax + div(ax - bx, 2), ay + div(by - ay, 2)} }, n-1),
      split_triangle({ {bx + div(ax - bx, 2), ay + div(by - ay, 2) + 1}, {bx,by}, {bx + div(cx - bx,2) - 1, by} }, n-1),
      split_triangle({ {cx - div(ax - bx, 2), ay + div(by - ay, 2) + 1}, {cx - div(cx - bx,2) + 1,by}, {cx,cy} }, n-1)
    ])
  end

end
