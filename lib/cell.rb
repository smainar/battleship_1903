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

  def render(show_hidden_ships = false)
    if show_hidden_ships == true && @ship != nil && @fired_upon == false
      "S"
    elsif @fired_upon == true && @ship       == nil
      "M"
    elsif @fired_upon == true && @ship.sunk? == false
      "H"
    elsif @fired_upon == true && @ship.sunk? == true
      "X"
    else
      "."
    end
  end

end
