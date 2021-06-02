defmodule Fibonacci do
  @moduledoc """
  https://www.hackerrank.com/challenges/functional-programming-warmups-in-recursion---fibonacci-numbers/problem
  [x] Solved
  """

  def main do
    [a] = IO.read(:stdio, :line)
    |> String.split([" ", "\n"])
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&String.to_integer(&1))

    fibonacci(a)
    |> IO.puts
  end

  def fibonacci(n) when n == 1,  do: 0
  def fibonacci(n) when n == 2,  do: 1
  def fibonacci(n), do: fibonacci(n-1) + fibonacci(n-2)
end
