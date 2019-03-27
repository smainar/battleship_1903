class Computer
  attr_reader :board,
              :possible_targets

  def initialize(computer_board, player_board)
    @computer_board   = computer_board
    @player_board     = player_board
    @computer_ships   = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @possible_targets = player_board.cells.keys.shuffle
  end

  def fire_at_will(target)
    @player_board.cells[target].fire_upon
  end

  def target
    @possible_targets.pop
  end

  def place_ships
    @computer_ships.each do |ship|
      ship_coordinates = validate_random_coordinates(ship)
      @computer_board.place(ship, ship_coordinates)
    end
  end

  def validate_random_coordinates(ship)
    ship_coordinates = @computer_board.cells.keys.sample(ship.length)
    until @computer_board.valid_placement?(ship, ship_coordinates)
      ship_coordinates = @computer_board.cells.keys.sample(ship.length)
    end
    ship_coordinates
  end

end
