require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerPirateTest < MiniTest::Test

  def setup
    @board            = Board.new
    @pirate_board     = Board.new
    @cruiser          = Ship.new("Cruiser", 3)
    @submarine        = Ship.new("Submarine", 2)
    @pirate_cruiser   = Ship.new("Pirate Cruiser", 3)
    @pirate_submarine = Ship.new("Pirate Cruiser", 3)
    @computer_pirate  = ComputerPirate.new(@board)
  end

  def test_it_exists
    assert_instance_of ComputerPirate, @computer_pirate
  end

  def test_it_can_welcome_player
    assert_equal "Welcome to BATTLESHIP!  Press p to play or q to quit...", @computer_pirate.welcome
  end

  def test_it_can_generate_two_player_ships
    assert_equal 2, @computer_pirate.generate_player_ships.count
  end

  def test_it_can_generate_two_pirate_ships
    assert_equal 2, @computer_pirate.generate_pirate_ships.count
  end

  def test_it_knows_possible_horizontal_cruiser_coordinates
    assert_equal 8, @computer_pirate.horizontal_cruiser_locations.count
  end

  def test_it_knows_possible_horizontal_submarine_coordinates
    assert_equal 12, @computer_pirate.horizontal_submarine_locations.count
  end

end
