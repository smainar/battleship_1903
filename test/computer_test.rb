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
    @computer       = Computer.new(@computer_board, @player_board)
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_by_default_it_has_two_ships
    assert_equal 2, @computer.computer_ships.count
  end

  def test_by_default_it_has_an_array_of_16_targets_to_fire_upon
    assert_equal 16, @computer.possible_targets.count
  end

  def test_it_can_fire_16_times_at_unique_targets
    16.times do
      @computer.fire_at_will(@computer.target)
    end

    assert_empty @computer.possible_targets
  end

  def test_it_can_return_ship_coordinates_that_pass_placement_validation
    @cruiser   = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

    assert_equal 3, @computer.validate_random_coordinates(@cruiser).count

    assert_equal 2, @computer.validate_random_coordinates(@submarine).count
  end

end
