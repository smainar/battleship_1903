class ComputerPlayer
  attr_reader :board,
              :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
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
