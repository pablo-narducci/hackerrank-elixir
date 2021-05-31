defmodule GCD do
  @moduledoc """
  Documentation for `Hackerrank`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hackerrank.hello()
      :world

  """
  def main do
    [a, b] = IO.read(:stdio, :line)
    |> String.split([" ", "\n"])
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&String.to_integer(&1))

    gcd(max(a,b), min(a,b))
    |> IO.puts
  end

  def gcd(x, y) when x == y do
    x
  end

  def gcd(_, y) when y == 1 do
    1
  end

  def gcd(x, y) do
    { x, y } = { max(x-y, y), min(x-y, y) }

    gcd(x, y)
  end

end
