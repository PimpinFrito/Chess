# frozen_string_literal: true

class GamePiece
  ROW_SIZE = 8
  COL_SIZE = 8
  @name = nil
  @color = nil
  WHITE = "White"
  BLACK = "Black"
  EMPTY_POSITION = "   "

  # def initialize(color)
  #   @color = color
  # end
  #

  #For testing
  def initialize(color, name, img)
    # Raise an error if any required argument is nil or empty
    raise ArgumentError, 'Color must be provided' if color.nil? || color.empty?
    raise ArgumentError, 'Name must be provided' if name.nil? || name.empty?
    raise ArgumentError, 'Img of game piece must be provided' if img.nil? || !img.is_a?(String)

    @color = color
    @name = name
    @img = (@color == WHITE ? "\033[97m#{img}" : "\033[30m#{img}")
  end

  def cell_empty? (row, column, board)
    board[row][column] == EMPTY_POSITION
  end

  def enemy_piece_in_cell?(row, column, board)
    board[row][column].get_color != @color
  end

  def cell_available(row, column, board)
    return false unless move_inbounds?([row, column])
    return true if cell_empty?(row, column, board)
    enemy_piece_in_cell?(row, column, board)
  end

  def cell_occupied(row, column, board)
    !cell_empty?(row, column, board)
  end

  def to_s
    " #{@img} "
  end


  def get_color
    @color
  end

  def add_move_if_enemy_piece_is_found(board, current_row, column, moves)
    cell = board[current_row][column]
    if cell.is_a?(GamePiece) && cell.get_color != get_color
      p "Chosen Cell: #{cell.get_color}"
      p "Self: #{get_color}"
      moves.push([current_row, column])
    end
  end

  def get_name
    @name
  end

  def legal_moves(piece_coords =[], board)
    raise StandardError, "Not overridden"
  end

  def move_inbounds?(move = [])
    possible_row = move[0]
    possible_col = move[1]
    possible_row < ROW_SIZE && possible_col < COL_SIZE && possible_row >= 0 && possible_col >= 0
  end
end
