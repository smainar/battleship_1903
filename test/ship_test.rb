require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_a_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_it_has_a_length
    assert_equal 3, @cruiser.length
  end

  def test_its_health
    assert_equal 3, @cruiser.health
  end

  def test_by_default_it_is_not_sunk
    assert_equal false, @cruiser.sunk?
  end

  def test_when_hit_its_health_decreases
    @cruiser.hit
    assert_equal 2, @cruiser.health

    @cruiser.hit
    assert_equal 1, @cruiser.health
  end

  def test_ship_can_report_if_it_is_sunk_or_not
    @cruiser.hit
    @cruiser.hit
    refute @cruiser.sunk?

    @cruiser.hit
    assert @cruiser.sunk?
  end
end
