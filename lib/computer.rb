class Computer
  attr_reader :board,
              :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end

  def place_ships
    @ships.each do |ship|
      ship_coordinates = validate_random_coordinates(ship)
      @board.place(ship, ship_coordinates)
    end
  end

  def validate_random_coordinates(ship)
    ship_coordinates = @board.cells.keys.sample(ship.length)
    until @board.valid_placement?(ship, ship_coordinates)
      ship_coordinates = @board.cells.keys.sample(ship.length)
    end
    ship_coordinates
  end

end
