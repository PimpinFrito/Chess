# frozen_string_literal: true
require_relative "GamePieces/pawn"
require_relative "GamePieces/rook"
require_relative "GamePieces/knight"
require_relative "GamePieces/queen"
require_relative "GamePieces/bishop"
require_relative "GamePieces/king"




class Board
  WHITE_BG =  "\033[103m"
  BLACK_BG =  "\033[42m" #Actually gray"\033[107m"
  RESET = "\033[0m"
  NUMBER_OF_ROWS = 8
  NUMBER_OF_COLUMNS = 8
  EMPTY_POSITION = "   "
  COLUMN_HASHMAP = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h" => 7}
  ROW_HASHMAP = {"1" => 7, "2" => 6, "3" => 5, "4" => 4, "5" => 3, "6"=> 2, "7" =>1, "8" => 0}
  WHITE = "White"
  BLACK = "Black"


  def initialize
    @rows = Array.new(NUMBER_OF_ROWS) { Array.new(NUMBER_OF_COLUMNS, EMPTY_POSITION) }
    @current_player = WHITE
    setup_board
  end

  def setup_board
    setup_white
    setup_black
  end

  def setup_white
    white_pawn_row = @rows[6]
    white_pawn_row.each_index do |col|
      white_pawn_row[col] = Pawn.new(WHITE, [6,col])
    end
    @rows[5][0] = Rook.new(WHITE)
    @rows[7][7] = Rook.new(WHITE)

    @rows[7][1] = Knight.new(WHITE)
    @rows[7][6] = Knight.new(WHITE)

    @rows[7][2] = Bishop.new(WHITE)
    @rows[7][5] = Bishop.new(WHITE)

    @rows[7][3] = Queen.new(WHITE)
    @rows[7][4] = King.new(WHITE)

  end

  def setup_black
    black_pawn_row = @rows[1]
    black_pawn_row.each_index do |col|
      black_pawn_row[col] = Pawn.new(BLACK, [7,col])
    end
    @rows[0][0] = Rook.new(BLACK)
    @rows[0][7] = Rook.new(BLACK)

    @rows[0][1] = Knight.new(BLACK)
    @rows[0][6] = Knight.new(BLACK)

    @rows[0][2] = Bishop.new(BLACK)
    @rows[0][5] = Bishop.new(BLACK)

    @rows[0][3] = Queen.new(BLACK)
    @rows[0][4] = King.new(BLACK)

  end

  def get_rows
    @rows
  end

  def display_board(location = [], move_list = [])
    current_cell_bg = BLACK_BG
    starting_piece_location_bg = "\033[44m"
    possible_move_bg = "\033[41m"

    #Extra starting space for printing the column letters
    print " "
    "abcdefgh".split("").each{ |column_letter| print "  #{column_letter}"}
    #Newline for board
    puts
    current_row = 9
    @rows.each_index do |row|
      current_row -= 1
      print current_row.to_s + " "
      @rows[row].each_index  do |column|
        if move_list.include?([row,column])
          print "#{possible_move_bg}#{@rows[row][column]}#{RESET}"
        elsif  location == [row,column]
          print "#{starting_piece_location_bg}#{@rows[row][column]}#{RESET}"
        else
          print "#{current_cell_bg}#{@rows[row][column]}#{RESET}"
        end
        current_cell_bg = current_cell_bg == WHITE_BG ? BLACK_BG : WHITE_BG
      end
      puts
      current_cell_bg = current_cell_bg == WHITE_BG ? BLACK_BG : WHITE_BG
    end
  end

  def display_possible_moves_for_piece(location)
    piece = @rows[location[0]][location[1]]
    raise ArgumentError, "piece must be a GamePiece subclass" unless piece.is_a? GamePiece
    move_list = piece.legal_moves(location, @rows)
    display_board(location, move_list)
  end

  def to_array_notation(position = [])
    if position.is_a? String
      position = position.split("")
    end
    p position
    col = position[0]
    chess_col = COLUMN_HASHMAP[col]
    row = position[1]
    chess_row = ROW_HASHMAP[row]
    [chess_row, chess_col]
  end

  def get_cell(position)
    row, column = to_array_notation(position)
    @rows[row][column]
  end

  def valid_first_move(raw_user_input)
    user_input = raw_user_input.split("")
    return false if user_input.length != 2
    return false unless ROW_HASHMAP.keys.include?(user_input[1])
    return false unless COLUMN_HASHMAP.keys.include?(user_input[0])
    cell = get_cell(raw_user_input)

    cell != EMPTY_POSITION && cell.get_color == @current_player
  end

  def choose_piece_to_move
    puts "Select a piece to move"
    user_input = gets.chomp.downcase
    until valid_first_move(user_input)
      puts "Not a valid move. Select a piece to move"
      user_input = gets.chomp.downcase
    end

    to_array_notation(user_input)
  end

  def valid_second_move(raw_user_input, move_list =[])
    user_input = raw_user_input.split("")
    return false unless user_input.length == 2
    return false unless ROW_HASHMAP.keys.include?(user_input[1])
    return false unless COLUMN_HASHMAP.keys.include?(user_input[0])
    array_notation = to_array_notation(raw_user_input)
    return false unless move_list.include? array_notation
    cell = get_cell(raw_user_input)
    cell == EMPTY_POSITION || cell.get_color != @current_player
  end

  def choose_cell_to_move_piece(from_cell)
    piece = @rows[from_cell[0]][from_cell[1]]
    raise ArgumentError, "from_cell contents must be a GamePiece subclass" unless piece.is_a? GamePiece
    move_list = piece.legal_moves(from_cell, @rows)
    user_input = gets.chomp.downcase
    until valid_second_move(user_input, move_list)
      puts "Not a valid move. Select a valid place to move"
      user_input = gets.chomp.downcase
    end

    to_array_notation(user_input)
  end

  def play_turn
    from_cell = choose_piece_to_move
    display_possible_moves_for_piece(from_cell)

    to_cell = choose_cell_to_move_piece(from_cell)
    move_piece(from_cell, to_cell)
    display_board
  end

  # def to_chess_notation(position = [])
  #   col = position[0]
  #   chess_col = COLUMN_HASHMAP[col]
  #   row = position[1]
  #   chess_row = ROW_HASHMAP[row]
  #   p "[#{chess_row} #{chess_col}]"
  #   [chess_col, chess_row]
  # end

  def move_piece(from, to)
    from_row, from_col = from
    to_row, to_col = to
    piece = @rows[from_row][from_col]
    @rows[to_row][to_col] = piece
    @rows[from_row][from_col] = EMPTY_POSITION
  end



end

board = Board.new
# pawn = Pawn.new(WHITE, [6, 0])
# rook = Rook.new(WHITE)
# board.display_possible_moves_for_piece(rook,[4,0])
board.display_board
board.play_turn
