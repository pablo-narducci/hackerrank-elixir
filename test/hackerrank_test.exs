defmodule HackerrankTest do
  use ExUnit.Case
  doctest Crosswords101

  test "London should fit vertically" do
    word_template = %{
      0 => '-',
      1 => 'O',
      2 => '-',
      3 => '-',
      4 => '-',
      5 => '-'
    }

    assert Crosswords101.fits?(word_template, to_char_list("LONDON")) == true
  end
end
