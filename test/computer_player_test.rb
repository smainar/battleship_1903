require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer_player'

class ComputerPlayerTest < MiniTest::Test

  def setup
    @board           = Board.new
    @computer_player = ComputerPlayer.new(@board, [@cruiser = Ship.new("Cruiser", 3), @submarine = Ship.new("Submarine", 2)])
  end

  def test_it_exists
    assert_instance_of ComputerPlayer, @computer_player
  end

  def test_by_default_it_has_two_ships
    assert_equal [@cruiser, @submarine], @computer_player.ships
    assert_equal 2, @computer_player.ships.count
  end

  def test_it_can_find_random_valid_coordinates_for_ships
    assert_equal 3, @computer_player.find_random_coordinates(@cruiser).count
    assert_equal 2, @computer_player.find_random_coordinates(@submarine).count
  end

  # def test_it_knows_all_horizontal_groups_of_three_coordinates
  #   expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"],
  #               ["A3", "A4", "B1"], ["A4", "B1", "B2"],
  #               ["B1", "B2", "B3"], ["B2", "B3", "B4"],
  #               ["B3", "B4", "C1"], ["B4", "C1", "C2"],
  #               ["C1", "C2", "C3"], ["C2", "C3", "C4"],
  #               ["C3", "C4", "D1"], ["C4", "D1", "D2"],
  #               ["D1", "D2", "D3"], ["D2", "D3", "D4"]]
  #   actual = @computer_player.horizontal_groups_of_three
  #
  #   assert_equal expected, actual
  #   assert_equal 14, @computer_player.horizontal_groups_of_three.count
  # end
  #
  # def test_it_knows_all_vertical_groups_of_three_coordinates
  #   expected = [["A1", "B1", "C1"], ["B1", "C1", "D1"],
  #               ["C1", "D1", "A2"], ["D1", "A2", "B2"],
  #               ["A2", "B2", "C2"], ["B2", "C2", "D2"],
  #               ["C2", "D2", "A3"], ["D2", "A3", "B3"],
  #               ["A3", "B3", "C3"], ["B3", "C3", "D3"],
  #               ["C3", "D3", "A4"], ["D3", "A4", "B4"],
  #               ["A4", "B4", "C4"], ["B4", "C4", "D4"]]
  #   actual = @computer_player.vertical_groups_of_three
  #
  #   assert_equal expected, actual
  #   assert_equal 14, @computer_player.vertical_groups_of_three.count
  # end
  #
  # def test_it_knows_valid_horizontal_cruiser_coordinates
  #   expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"],
  #               ["B1", "B2", "B3"], ["B2", "B3", "B4"],
  #               ["C1", "C2", "C3"], ["C2", "C3", "C4"],
  #               ["D1", "D2", "D3"], ["D2", "D3", "D4"]]
  #   actual = @computer_player.valid_horizontal_cruiser_locations
  #
  #   assert_equal expected, actual
  #   assert_equal 8, @computer_player.valid_horizontal_cruiser_locations.count
  # end
  #
  # def test_it_knows_all_horizontal_groups_of_two_coordinates
  #   expected = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"],
  #               ["A4", "B1"], ["B1", "B2"], ["B2", "B3"],
  #               ["B3", "B4"], ["B4", "C1"], ["C1", "C2"],
  #               ["C2", "C3"], ["C3", "C4"], ["C4", "D1"],
  #               ["D1", "D2"], ["D2", "D3"], ["D3", "D4"]]
  #   actual = @computer_player.horizontal_groups_of_two
  #
  #   assert_equal expected, actual
  #   assert_equal 15, @computer_player.horizontal_groups_of_two.count
  # end
  #
  # def test_it_knows_valid_horizontal_submarine_coordinates
  #   expected = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"],
  #               ["B1", "B2"], ["B2", "B3"], ["B3", "B4"],
  #               ["C1", "C2"], ["C2", "C3"], ["C3", "C4"],
  #               ["D1", "D2"], ["D2", "D3"], ["D3", "D4"]]
  #   actual = @computer_player.horizontal_submarine_locations
  #
  #   assert_equal = expected, actual
  #   assert_equal 12, @computer_player.horizontal_submarine_locations.count
  # end
end
