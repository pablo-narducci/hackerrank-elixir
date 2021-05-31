defmodule Pascal do

  def main do
    [a] = IO.read(:stdio, :line)
    |> String.split([" ", "\n"])
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&String.to_integer(&1))

    main_pascal(a)
    |> IO.puts
  end

  def main_pascal(n) do
    main_produce_line([[0, 1]], n - 1)
  end

  def to_formatted_string(x, "") do
    "#{x}"
  end

  def to_formatted_string(x, acum) do
    "#{acum} #{x}"
  end

  def main_produce_line(previous_lines, 0) do
    previous_lines
    |> Enum.reverse
    |> Enum.map(fn [_|t] -> t end)
    |> Enum.map(fn list -> Enum.reduce(list, "", fn x, acum -> to_formatted_string(x, acum) end) end)
    |> Enum.reduce("", fn x, acum -> "#{acum}#{x}\n" end)
  end

  def main_produce_line(previous_lines, remaining_steps) do
    [head|_] = previous_lines
    line = [0|produce_line(head, [])]
    main_produce_line([line|previous_lines], remaining_steps - 1)
  end

  def produce_line(prev_line, acum) when length(prev_line) == 2 do
    [a, b] = prev_line
    Enum.concat([1, a + b], acum)
  end

  def produce_line([a|[b|c]], acum) do
    produce_line([b|c], [a+b|acum])
  end

end
