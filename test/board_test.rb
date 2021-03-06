require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'

class BoardTest < Minitest::Test
  def setup
    @board     = Board.new
    @cruiser   = Ship.new("Cruiser", 3)
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
  end

  def test_ship_length_equals_ship_coordinate_count
  assert @board.valid_ship_length?(@cruiser, ["A1", "A2", "A4"])

  refute @board.valid_ship_length?(@submarine, ["A1", "C1", "D1"])
  refute @board.valid_ship_length?(@cruiser, ["A1", "A2"])
  end

  def test_if_ship_coordinates_are_in_same_row_and_adjacent
    assert @board.same_row_and_adjacent?(@cruiser, ["A2", "A3", "A4"])
    assert @board.same_row_and_adjacent?(@submarine, ["C2", "C3"])
    assert @board.same_row_and_adjacent?(@cruiser, ["B2", "B3", "B4"])

    refute @board.same_row_and_adjacent?(@cruiser, ["A1", "A2", "A4"])
    refute @board.same_row_and_adjacent?(@submarine, ["A1", "C1"])
    refute @board.same_row_and_adjacent?(@cruiser, ["A1", "A2", "B3"])
    refute @board.same_row_and_adjacent?(@cruiser, ["B4", "B3", "B2"])
    refute @board.same_row_and_adjacent?(@cruiser, ["A1", "A3", "A2"])
    refute @board.same_row_and_adjacent?(@submarine, ["B2", "D4"])
  end

  def test_if_ship_coordinates_are_in_same_column_and_adjacent
    assert @board.same_column_and_adjacent?(@submarine, ["A1", "B1"])
    assert @board.same_column_and_adjacent?(@submarine, ["C2", "D2"])
    assert @board.same_column_and_adjacent?(@cruiser, ["B1", "C1", "D1"])

    refute @board.same_column_and_adjacent?(@cruiser, ["A1", "B1", "C2"])
    refute @board.same_column_and_adjacent?(@submarine, ["B2", "C1"])
  end

  def test_that_coordinates_are_not_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_that_board_recognizes_valid_ship_placement
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_board_can_place_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]

    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship

    assert @cell_3.ship == @cell_2.ship
  end

  def test_that_ships_do_not_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert @board.valid_placement?(@submarine, ["D1", "D2"])

    refute @board.valid_placement?(@submarine, ["A1", "B1"])
    refute @board.valid_placement?(@submarine, ["A2", "A3"])
  end

  def test_board_can_render
    @board.place(@cruiser, ["A1", "A2", "A3"])

    expected =
          "  1 2 3 4 \n" +
          "A . . . . \n" +
          "B . . . . \n" +
          "C . . . . \n" +
          "D . . . . \n"

    assert_equal expected, @board.render
  end

  def test_board_can_render_with_hidden_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])

    expected =
          "  1 2 3 4 \n" +
          "A S S S . \n" +
          "B . . . . \n" +
          "C . . . . \n" +
          "D . . . . \n"
    assert_equal expected, @board.render(true)
  end

end
