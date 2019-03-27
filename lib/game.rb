require './lib/computer'
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
      @computer_board = Board.new
      @player_board = Board.new
      @computer = Computer.new(@computer_board, @player_board)
      @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
      @winner = nil
    end

  def start
    main_menu
    setup_game
    start_game
    end_game
  end

  def main_menu
    print "\n"
    puts "~~~ Welcome to BATTLESHIP ~~~"
    print "\n"
    puts "Enter p to play. Enter q to quit:"
    user_input = gets.chomp.downcase
    print "\n"

    while user_input != "p"
      if user_input == "q"
        exit!
      else
        puts "Invalid response. Enter p to play, or q to quit:"
      end
      user_input = gets.chomp.downcase
      print "\n"
    end
  end

  def setup_game
    # Computer can place ships randomly in valid locations
    @computer.place_ships
    # User can enter valid sequences to place both ships
    print "\n"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    print "\n"

    @player_ships.map do |ship|
      puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces): "
      user_input = gets.chomp.upcase
      user_input = user_input.split(" ")
      print "\n"

      # Entering invalid ship placements prompts user to enter valid placements
      while @player_board.valid_placement?(ship, user_input) == false
        puts "Those are invalid coordinates. Please try again: "
        user_input = gets.chomp.upcase
        user_input = user_input.split(" ")
        print "\n"
      end
      @player_board.place(ship, user_input)
    end
  end

  def start_game
    until @winner != nil

    # During the main game, players take turns firing at one another by selecting positions on the grid to attack.
    #
    # A single turn consists of:

    # Displaying the boards
      print "\n\n"
      puts "=============COMPUTER BOARD============="
      print @computer_board.render(true)

      print "\n"
      puts "==============PLAYER BOARD=============="
      print @player_board.render(true)

      print "\n\n"

      # Player choosing a coordinate to fire on
      puts "Enter the coordinate for your shot: "
      user_input = gets.chomp.upcase.to_s
      print "\n"

      while @computer_board.valid_coordinate?(user_input) == false
        puts "Please enter a valid coordinate: "
      end
      @computer_board.cells[user_input].fire_upon

      # Computer choosing a coordinate to fire on
      current_target = @computer.target
      @computer.fire_at_will(current_target)

      # Reporting the result of the Player’s shot
      # @computer.player_board.some_method_name
      puts "Your shot on #{user_input} was a #{@computer_board.cells[user_input].display_results}."

      # Reporting the result of the Computer’s shot
      puts "My shot on #{current_target} was a #{@player_board.cells[current_target].display_results}."

      puts "Press enter to continue."

      gets
    end
    # continue until there is a winner = all ships sunk
    check_for_winner
  end

  def check_for_winner
    # if all ships sunk == winner
    # check player_board
    # check computer_board
    # assign winner
    player_wins = @computer_ships.all? do |ship|
      ship.sunk?
    end
    computer_wins = @player_ships.all? do |ship|
      ship.sunk?
    end

    if player_wins == true
      @winner = "You won!"
    elsif computer_wins == true
      @winner = "I won!"
    end
    @winner
  end

  def end_game
    print @winner
    start
    # Game ends when all the user’s ships are sunk
    # Game ends when all the computer’s ships are sunk
    # Game reports who won
    # Game returns user back to the Main Menu
    # The game is over when either the computer or the user sinks all of the enemy ships. When this happens, the user should see a message stating who won
  end

end
