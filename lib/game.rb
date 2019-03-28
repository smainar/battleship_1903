require './lib/computer'
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  def initialize
    @computer_board  = Board.new
    @player_board    = Board.new
    @computer        = Computer.new(@computer_board, @player_board)
    @player_ships    = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @winner          = nil
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
    @computer.place_ships

    print "\n"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    print "\n"

    @player_ships.map do |ship|
      puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
      user_input = gets.chomp.upcase
      user_input = user_input.split(" ")
      print "\n"

      while @player_board.valid_placement?(ship, user_input) == false
        puts "Those are invalid coordinates. Please try again:"
        user_input = gets.chomp.upcase
        user_input = user_input.split(" ")
        print "\n"
      end
      @player_board.place(ship, user_input)
    end
  end

  def start_game
    until @winner != nil

      print "\n"
      puts "=============COMPUTER BOARD============="
      print @computer_board.render(true)
      print "\n"

      puts "==============PLAYER BOARD=============="
      print @player_board.render(true)
      print "\n"

      successful_shot = false
      puts "Enter a coordinate for your shot:"
      until successful_shot == true
        user_input = gets.chomp.upcase
        print "\n"
        if @computer_board.valid_coordinate?(user_input)
          if @computer_board.cells[user_input].fired_upon? == false
            successful_shot = true
          elsif @computer_board.cells[user_input].fired_upon?
            puts "You have already fired upon that cell! Choose again:"
          end
        else
          puts "Please enter a valid coordinate:"
        end
      end

      @computer_board.cells[user_input].fire_upon

      current_target = @computer.target
      @computer.fire_at_will(current_target)

      puts "Your shot on #{user_input} was a #{@computer_board.cells[user_input].display_results}."
      puts "My shot on #{current_target} was a #{@player_board.cells[current_target].display_results}."
      puts "Press enter to continue."
      gets

      check_for_winner
    end
  end

  def check_for_winner
    player_wins = @computer.computer_ships.all? do |ship|
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
    print "\n\n"

    @computer_board = Board.new
    @player_board   = Board.new
    @computer       = Computer.new(@computer_board, @player_board)
    @player_ships   = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @winner         = nil

    start
  end

end
