defmodule HackerrankTest do
  use ExUnit.Case
  doctest Crosswords101

  test "London should fit vertically" do
    word_template = %{
      0 => "-",
      1 => "O",
      2 => "-",
      3 => "-",
      4 => "-",
      5 => "-"
    }

    assert Crosswords101.fits?(word_template, String.graphemes("LONDON")) == true
  end

  test "London should not fit vertically" do
    word_template = %{
      0 => "-",
      1 => "E",
      2 => "-",
      3 => "-",
      4 => "-",
      5 => "-"
    }

    assert Crosswords101.fits?(word_template, String.graphemes("LONDON")) == false
  end

  test "London should fit horizontally" do
    word_template = %{
      0 => "-",
      10 => "O",
      20 => "-",
      30 => "-",
      40 => "-",
      50 => "-"
    }

    assert Crosswords101.fits?(word_template, String.graphemes("LONDON")) == true
  end

  test "London should not fit due to lenght" do
    word_template = %{
      0 => "-",
      10 => "O",
      20 => "-",
      30 => "-",
      40 => "-"
    }

    assert Crosswords101.fits?(word_template, String.graphemes("LONDON")) == false
  end

  test "London fits in template" do
    word_template = %{
      0 => "-",
      10 => "O",
      20 => "-",
      30 => "-",
      40 => "-",
      50 => "-"
    }

    result = %{
      0  => "L",
      10 => "O",
      20 => "N",
      30 => "D",
      40 => "O",
      50 => "N"
    }

    assert Crosswords101.fit(word_template, String.graphemes("LONDON")) == result
  end

  test "Try fit" do
    word_template = %{
      0 => "-",
      10 => "O",
      20 => "-",
      30 => "-",
      40 => "-",
      50 => "-"
    }

    result = %{
      0  => "L",
      10 => "O",
      20 => "N",
      30 => "D",
      40 => "O",
      50 => "N"
    }

    assert Crosswords101.fit(word_template, String.graphemes("LONDON")) == result
  end

  test "Try complete" do
    grid = [%{
      1  => "-",
      11 => "-",
      21 => "-",
      31 => "-",
      41 => "-",
      51 => "-"
    },
    %{
      31 => "-",
      32 => "-",
      33 => "-",
      34 => "-",
      35 => "-"
    },
    %{
      35 => "-",
      45 => "-",
      55 => "-",
      65 => "-",
      75 => "-",
      85 => "-",
      95 => "-"
    },
    %{
      72 => "-",
      73 => "-",
      74 => "-",
      75 => "-",
      76 => "-",
      77 => "-"
    }
  ]

  words = ["LONDON", "DELHI", "ICELAND", "ANKARA"]
  |> Enum.map(&String.graphemes(&1))

  result = [%{
      1  => "L",
      11 => "O",
      21 => "N",
      31 => "D",
      41 => "O",
      51 => "N"
    },
    %{
      31 => "D",
      32 => "E",
      33 => "L",
      34 => "H",
      35 => "I"
    },
    %{
      35 => "I",
      45 => "C",
      55 => "E",
      65 => "L",
      75 => "A",
      85 => "N",
      95 => "D"
    },
    %{
      72 => "A",
      73 => "N",
      74 => "K",
      75 => "A",
      76 => "R",
      77 => "A"
    }
  ]

  #IO.inspect(Crosswords101.complete({[], grid}, words))

  assert :lists.sort(Crosswords101.complete({[], grid}, words)) == :lists.sort(result)
  end
end
