require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
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

    # assert_instance_of Cell, @board.cells.values
  end

  def test_it_can_validate_single_coordinates_on_the_board
    assert @board.valid_coordinate?("A1")

    assert @board.valid_coordinate?("D4")

    refute @board.valid_coordinate?("A5")

    refute @board.valid_coordinate?("E1")

    refute @board.valid_coordinate?("A22")
  end

  def test_if_number_of_coordinates_is_same_as_ship_length
    refute @board.valid_placement?(cruiser, ["A1", "A2"])

    refute @board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_if_coordinates_are_consecutive
    refute @board.valid_placement?(cruiser, ["A1", "A2", "A4"])

    refute @board.valid_placement?(submarine, ["A1", "C1"])

    refute @board.valid_placement?(cruiser, ["A3", "A2", "A1"])

    refute @board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_that_coordinates_are_not_diagonal
    refute @board.valid_placement?(cruiser, ["A1", "B2", "C3"])

    refute @board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_that_board_recognizes_valid_ship_placement
    assert @board.valid_placement?(submarine, ["A1", "A2"])

    assert @board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

end
