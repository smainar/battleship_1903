require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer_player'

class ComputerPlayerTest < MiniTest::Test

  def setup
    @board           = Board.new
    @pirate_board    = Board.new
    @computer_player = ComputerPlayer.new(@board, [@cruiser = Ship.new("Cruiser", 3), @submarine = Ship.new("Submarine", 2)])
  end

  def test_it_exists
    assert_instance_of ComputerPlayer, @computer_player
  end

  def test_by_default_it_has_two_ships
    assert_equal [@cruiser, @submarine], @computer_player.ships
    assert_equal 2, @computer_player.ships.count
  end

  def test_it_knows_possible_horizontal_cruiser_coordinates
    assert_equal 8, @computer_player.horizontal_cruiser_locations.count
  end

  def test_it_knows_possible_horizontal_submarine_coordinates
    assert_equal 12, @computer_player.horizontal_submarine_locations.count
  end

end
