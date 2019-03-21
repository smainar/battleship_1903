require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_instance_of Hash, @board.cells

    assert_equal 16, @board.cells.length
  end

  def test_it_can_validate_single_coordinates_on_the_board
    assert @board.valid_coordinate?("A1")

    assert @board.valid_coordinate?("D4")

    refute @board.valid_coordinate?("A5")

    refute @board.valid_coordinate?("E1")

    refute @board.valid_coordinate?("A22")

    refute @board.valid_coordinate?("O15")
  end

  def test_ship_length_equals_ship_coordinate_count
  assert @board.valid_ship_length?(@cruiser, ["A1", "A2", "A4"])

  refute @board.valid_ship_length?(@submarine, ["A1", "C1", "D1"])

  refute @board.valid_ship_length?(@cruiser, ["A1", "A2"])

  refute @board.valid_ship_length?(@submarine, ["A2", "A3", "A4"])
  end

  def test_if_ship_coordinates_are_in_same_row_and_adjacent
    refute @board.same_row_and_adjacent(@cruiser, ["A1", "A2", "A4"])

    refute @board.same_row_and_adjacent(@submarine, ["A1", "C1"])

    refute @board.same_row_and_adjacent(@cruiser, ["A1", "A2", "B3"])

    refute @board.same_row_and_adjacent(@cruiser, ["B4", "B3", "B2"])

    assert @board.same_row_and_adjacent(@cruiser, ["A2", "A3", "A4"])

    assert @board.same_row_and_adjacent(@submarine, ["C2", "C3"])

    assert @board.same_row_and_adjacent(@cruiser, ["B2", "B3", "B4"])
  end

  def test_if_ship_coordinates_are_in_same_column
    skip
    assert_equal false, @board.coordinates_in_the_same_column(@cruiser, ["A1", "A2", "A4"])

    assert_equal true, @board.coordinates_in_the_same_column(@submarine, ["A1", "C1"])

    assert_equal false, @board.coordinates_in_the_same_column(@cruiser, ["A1", "C2", "B4"])
  end

  def test_if_coordinates_are_consecutive
    skip
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])

    refute @board.valid_placement?(@submarine, ["A1", "C1"])

    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])

    refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_that_coordinates_are_not_diagonal
    skip
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])

    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_that_board_recognizes_valid_ship_placement
    skip
    assert @board.valid_placement?(@submarine, ["A1", "A2"])

    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

end
