defmodule StringPermute do

  def read_integer do
    IO.read(:stdio, :line)
    |> String.trim
    |> String.to_integer
  end

  def process_line(0), do: nil

  def process_line(n) do
    IO.read(:stdio, :line)
    |> String.trim
    |> String.graphemes
    |> Enum.chunk_every(2)
    |> Enum.reduce("", fn [a,b], acc -> "#{acc}#{b}#{a}" end)
    |> IO.puts

    process_line(n-1)
  end

  def main do
    n = read_integer()
    process_line(n)
  end

end
