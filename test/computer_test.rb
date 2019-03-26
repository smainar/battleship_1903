require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerTest < MiniTest::Test

  def setup
    @computer_board = Board.new
    @player_board   = Board.new
    @computer       = Computer.new(@computer_board, @player_board, [@cruiser = Ship.new("Cruiser", 3), @submarine      = Ship.new("Submarine", 2)])
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_by_default_it_has_two_ships
    assert_equal [@cruiser, @submarine], @computer.ships
    assert_equal 2, @computer.ships.count
  end

  def test_by_default_it_has_an_array_of_16_targets_to_fire_upon
    assert_equal 16, @computer.targets.count
  end

  def test_it_can_fire_16_times_at_unique_targets
    16.times do
      @computer.fire_at_will(@computer.target)
    end

    assert_empty @computer.targets
  end

  def test_it_can_validate_random_coordinates_for_ships
    assert_equal 3, @computer.validate_random_coordinates(@cruiser).count
    assert_equal 2, @computer.validate_random_coordinates(@submarine).count
  end

end
