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

  test "update existing word" do
    existing_word = %{
      11 => "-",
      21 => "-",
      31 => "-"
    }

    current_word = %{21 => "X"}

    result = %{
      11 => "-",
      21 => "X",
      31 => "-"
    }

    assert Crosswords101.update_word_template(existing_word, current_word) == result

  end

  test "Can complete crossword" do
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

  actual = :lists.sort(Crosswords101.main_complete(grid, words))

  assert actual == :lists.sort(result)
  end

  test "Should not complete crossword when the sizes are correct but the words do not match" do
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

  words = ["LONYON", "DELHI", "ICELAND", "ANKARA"]
  |> Enum.map(&String.graphemes(&1))

  result = []

  actual = :lists.sort(Crosswords101.main_complete(grid, words))

  assert actual == :lists.sort(result)
  end

  test "Complete can deal with multiple fits" do
    grid = [%{
      13  => "-",
      23 => "-",
      33 => "-",
      43 => "-",
      53 => "-"
    },
    %{
      15  => "-",
      25 => "-",
      35 => "-",
      45 => "-",
      55 => "-"
    },
    %{
      22  => "-",
      23 => "-",
      24 => "-",
      25 => "-",
      26 => "-"
    },
    %{
      42  => "-",
      43 => "-",
      44 => "-",
      45 => "-",
      46 => "-"
    },
  ]

  words = ["AXAXA", "BXBXB", "CXCXC", "DXDXD"]
  |> Enum.map(&String.graphemes(&1))

  actual = Crosswords101.main_complete(grid, words)

  assert length(actual) == 4
  end

  test "can parse line" do
    #Crosswords101.to_map(2, 0, String.graphemes("++--+-"), %{})
    #|>IO.inspect
  end

  test "can parse multiple lines" do
    [String.graphemes("++--+-"), String.graphemes("+----+")]
    |>Crosswords101.to_grid
    |>IO.inspect
  end

  test "lines are converted to grid" do
    parsed_lines = [
      ["+", "-", "+", "+", "+", "+", "+", "+", "+", "+"],
      ["+", "-", "+", "+", "+", "+", "+", "+", "+", "+"],
      ["+", "-", "+", "+", "+", "+", "+", "+", "+", "+"],
      ["+", "-", "-", "-", "-", "-", "+", "+", "+", "+"],
      ["+", "-", "+", "+", "+", "-", "+", "+", "+", "+"],
      ["+", "-", "+", "+", "+", "-", "+", "+", "+", "+"],
      ["+", "+", "+", "+", "+", "-", "+", "+", "+", "+"],
      ["+", "+", "-", "-", "-", "-", "-", "-", "+", "+"],
      ["+", "+", "+", "+", "+", "-", "+", "+", "+", "+"],
      ["+", "+", "+", "+", "+", "-", "+", "+", "+", "+"]
    ]

    expected = [%{
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

  actual = parsed_lines
  |> Crosswords101.to_grid
  |> Crosswords101.to_word_templates

  assert :lists.sort(actual) == :lists.sort(expected)

  end

  test "can parse city names" do
    line = "LONDON;DELHI;ICELAND;ANKARA"

    expected = [
      ["L", "O", "N", "D", "O", "N"],
      ["D", "E", "L", "H", "I"],
      ["I", "C", "E", "L", "A", "N", "D"],
      ["A", "N", "K", "A", "R", "A"]
    ]

    assert Crosswords101.parse_names(line) == expected
  end


end
