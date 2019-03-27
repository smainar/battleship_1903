class Board
  attr_reader :cells

  def initialize
    @cells = new_cells
  end

  def new_cells
    {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
     }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, ship_coordinates)
    ship_coordinates.each do |coordinate|
      return false if valid_coordinate?(coordinate) == false
    end

    valid_length     = valid_ship_length?(ship, ship_coordinates)
    no_overlap       = no_ship_overlap?(ship, ship_coordinates)
    row_adjacent     = same_row_and_adjacent?(ship, ship_coordinates)
    column_adjacent  = same_column_and_adjacent?(ship, ship_coordinates)
    valid_length && no_overlap && (row_adjacent || column_adjacent)
  end

  def valid_ship_length?(ship, ship_coordinates)
    ship.length == ship_coordinates.length
  end

  def no_ship_overlap?(ship, ship_coordinates)
    ship_coordinates.all? do |coordinate|
      @cells[coordinate].empty?
    end
  end

  def same_row_and_adjacent?(ship, ship_coordinates)
    letter_array = ship_coordinates.map do |ship_coordinate|
      ship_coordinate[0]
    end

    if letter_array.uniq.count == 1
      number_array = ship_coordinates.map do |ship_coordinate|
        ship_coordinate[1]
      end

      number_array.each_cons(2).all? do |current_num, next_num|
          current_num.to_i == next_num.to_i - 1
      end
    else
      false
    end
  end

  def same_column_and_adjacent?(ship, ship_coordinates)
    number_array = ship_coordinates.map do |ship_coordinate|
      ship_coordinate[1]
    end

    if number_array.uniq.count == 1
      letter_array = ship_coordinates.map do |ship_coordinate|
        ship_coordinate[0]
      end

      letter_array.each_cons(2).all? do |current_letter, next_letter|
          current_letter.ord == next_letter.ord - 1
      end
    else
      false
    end
  end

  def place(ship, ship_coordinates)
    if valid_placement?(ship, ship_coordinates)
      ship_coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render(unveil_ships = false)
    row_header = @cells.keys.map do |key|
      key[0]
    end.uniq

    column_header = @cells.keys.map do |key|
      key[1]
    end.uniq

    render_board = "  #{column_header.join(" ")} \n"

    row_header.each do |letter|
      render_board += "#{letter}"
      column_header.each do |number|
        render_board += " #{@cells[letter + number].render(unveil_ships)}"
      end
      render_board += " \n"
    end
    render_board
  end

end
