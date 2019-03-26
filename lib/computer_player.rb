class ComputerPlayer
  attr_reader :board,
              :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end

  def place_ships
    @ships.each do |ship|
      ship_coordinates = find_random_coordinates(ship)
      @board.place(ship, ship_coordinates)
    end
  end

  def find_random_coordinates(ship)
    ship_coordinates = @board.cells.keys.sample(ship.length)
    until @board.valid_placement?(ship, ship_coordinates)
      ship_coordinates = @board.cells.keys.sample(ship.length)
    end
    ship_coordinates
  end

  # def valid_horizontal_cruiser_locations
  #   horizontal_groups_of_three.reject! do |coords|
  #     coords[0][0] != coords[1][0] || coords[1][0] != coords[2][0]
  #   end
  # end
  #
  # def horizontal_groups_of_three
  #   horizontal_groups = []
  #   @board.cells.keys.each_cons(3) do |coordinates|
  #     horizontal_groups << coordinates
  #   end
  #   horizontal_groups
  # end
  #
  # def horizontal_submarine_locations
  #   horizontal_groups_of_two.reject! do |coords|
  #     coords[0][0] != coords[1][0]
  #   end
  # end
  #
  # def horizontal_groups_of_two
  #   horizontal_groups = []
  #   @board.cells.keys.each_cons(2) do |coordinates|
  #     horizontal_groups << coordinates
  #   end
  #   horizontal_groups
  # end
end
