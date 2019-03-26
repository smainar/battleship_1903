require './lib/computer'
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
      @computer_board = Board.new
      @player_board = Board.new
      @computer = Computer.new(@computer_board, @computer_ships)
      @computer_ships = [cruiser_1 = Ship.new("Cruiser", 3), submarine_1 = Ship.new("Submarine", 2]
      @player_ships = [cruiser_2 = Ship.new("Cruiser", 3), submarine_2= Ship.new("Submarine", 2]
    end

  def start
    main_menu
    setup_game
    start_game
    end_game
  end

  def main_menu
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    user_input = gets.chomp.downcase

    if user_input == "p"
      setup
    elsif user_input == "q"
      exit!
    end

    until user_input == "p" || user_input == "q"
      p "Invalid response. Enter p to play, or q to quit."
      user_input = gets.chomp.downcase
    end
  end

  def setup_game
    # Computer can place ships randomly in valid locations
    @computer.place_ships
    # User can enter valid sequences to place both ships
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is two units long and the Submarine is three units long."

    @player_ships.map do |ship|
      p "Enter the coordinates for the #{ship.name} (#{ship.length} spaces): "
      user_input = gets.chomp.upcase
      user_input.split(" ").to_a

      # Entering invalid ship placements prompts user to enter valid placements
      while @player_board.valid_placement?(ship, user_input) == false
        p "Invalid coordinates. Please try again."
        user_input = gets.chomp.upcase
        user_input.split(" ").to_a
      end
      @player_board.place(ship, user_input)
    end
  end

  def start_game
  end

  def end_game
    # Game ends when all the user’s ships are sunk
    # Game ends when all the computer’s ships are sunk
    # Game reports who won
      # You won!
      # or
      # I won!
    # Game returns user back to the Main Menu

    # The game is over when either the computer or the user sinks all of the enemy ships. When this happens, the user should see a message stating who won
  end

end
