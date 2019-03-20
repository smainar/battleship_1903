require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_by_default_it_does_not_contain_a_ship
    assert_nil @cell.ship
  end

  def test_by_default_the_cell_is_empty
    assert @cell.empty?
  end

  def test_it_can_place_the_ship_and_return_it_is_not_empty
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship

    refute @cell.empty?
  end

  def test_by_default_cell_is_not_fired_upon
    @cell.place_ship(@cruiser)
    refute @cell.fired_upon?
  end

  def test_cell_can_be_fired_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert @cell.fired_upon?
  end

  def test_ship_health_decreases_when_fired_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end


end
