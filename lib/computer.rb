class ComputerPirate
  attr_reader :pirate_ships,
              :player_ships

  def initialize(board)
    @board        = board
    @pirate_ships = []
    @player_ships = []
  end

  def welcome
    "Welcome to BATTLESHIP!  Press p to play or q to quit..."
  end

  def generate_player_ships
    @player_ships << @cruiser
    @player_ships << @submarine
  end

  def generate_pirate_ships
    @pirate_ships << @pirate_cruiser
    @pirate_ships << @pirate_submarine
  end

  def horizontal_cruiser_locations
    horizontal_groups_of_three.reject! do |coords|
        coords[0][0] != coords[1][0] || coords[1][0] != coords[2][0]
    end
  end

  def horizontal_groups_of_three
    horizontal_groups = []
    @board.cells.keys.each_cons(3) do |coordinates|
      horizontal_groups << coordinates
    end
    horizontal_groups
  end

  def horizontal_submarine_locations
    horizontal_groups_of_two.reject! do |coords|
        coords[0][0] != coords[1][0]
    end
  end

  def horizontal_groups_of_two
    horizontal_groups = []
    @board.cells.keys.each_cons(2) do |coordinates|
      horizontal_groups << coordinates
    end
    horizontal_groups
  end

  # def pick_random_cruiser_coordinates
  #   possible_locations = []
  #   require "pry"; binding.pry
  #   @board.cells.keys.each_cons(3) do |coordinates|
  #     possible_locations << coordinates
  #   end
  #   possible_locations.sample
  # end

end




# def start_game
#   welcome
#   user_input = gets.chomp
#   if user_input == "p"
#     start
#   elsif user_input == "q"
#     game_over
#   else
#     "That's not a p or a q..."
#   end
# end
