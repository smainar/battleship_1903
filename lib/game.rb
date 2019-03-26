require './lib/computer'
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
      @computer_board = Board.new
      @player_board = Board.new
      @computer = Computer.new(@computer_board, @player_board, @computer_ships)
      @computer_ships = [cruiser_1 = Ship.new("Cruiser", 3), submarine_1 = Ship.new("Submarine", 2]
      @player_ships = [cruiser_2 = Ship.new("Cruiser", 3), submarine_2= Ship.new("Submarine", 2]
      @winner = nil
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
      p "Invalid response. Enter p to play, or q to quit: "
      user_input = gets.chomp.downcase
    end
  end

  def setup_game
    # Computer can place ships randomly in valid locations
    @computer.place_ships
    # User can enter valid sequences to place both ships
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is three units long and the Submarine is two units long."

    @player_ships.map do |ship|
      p "Enter the coordinates for the #{ship.name} (#{ship.length} spaces): "
      user_input = gets.chomp.upcase
      user_input.split(" ").to_a

      # Entering invalid ship placements prompts user to enter valid placements
      while @player_board.valid_placement?(ship, user_input) == false
        p "Those are invalid coordinates. Please try again: "
        user_input = gets.chomp.upcase
        user_input.split(" ").to_a
      end
      @player_board.place(ship, user_input)
    end
  end

  def start_game
    until @winner == something do

    # During the main game, players take turns firing at one another by selecting positions on the grid to attack.
    #
    # A single turn consists of:

    # Displaying the boards
      p "=============COMPUTER BOARD============="
      @computer_board.render
      p "==============PLAYER BOARD=============="
      @player_board.render(true)

      # Player choosing a coordinate to fire on
      p "Enter the coordinate for your shot: "
      user_input = gets.chomp.upcase.to_s

      while @computer_board.valid_coordinate?(user_input) == false
        p "Please enter a valid coordinate: "
      end
      @computer_board.cells[user_input].fire_upon

      # Computer choosing a coordinate to fire on
      current_target = @computer.fire_at_will(target)

      # Reporting the result of the Player’s shot
      @computer.player_board.some_method_name
      p "Your shot on #{user_input} was a #{@computer_board.cells[user_input].display_results}."
      # Reporting the result of the Computer’s shot

      p "My shot on #{current_target} was a #{@player_board.cells[current_target].display_results}."
    end
    # continue until there is a winner = all ships sunk
  end

  def end_game

    # Game ends when all the user’s ships are sunk
    # Game ends when all the computer’s ships are sunk
    # Game reports who won
      p "You won!"

      p "I won!"
    # Game returns user back to the Main Menu

    # The game is over when either the computer or the user sinks all of the enemy ships. When this happens, the user should see a message stating who won
  end

end
