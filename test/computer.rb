require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerTest < MiniTest::Test

  def setup
    @board    = Board.new
    @computer = Computer.new(@board, [@cruiser = Ship.new("Cruiser", 3), @submarine = Ship.new("Submarine", 2)])
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_by_default_it_has_two_ships
    assert_equal [@cruiser, @submarine], @computer.ships
    assert_equal 2, @computer.ships.count
  end

  def test_it_can_validate_random_coordinates_for_ships
    assert_equal 3, @computer.validate_random_coordinates(@cruiser).count
    assert_equal 2, @computer.validate_random_coordinates(@submarine).count
  end

end
