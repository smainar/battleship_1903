class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship.hit unless @ship == nil
  end

  def render
    if @fired_upon == false
      p "."
    elsif @fired_upon == true && @ship == nil
      p "M"
    elsif @fired_upon == true && @ship.sunk? == false
      p "H"
    elsif @fired_upon == true && @ship.sunk? == true
      p "X"
    end

  end

end
