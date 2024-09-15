# frozen_string_literal: true

class Bishop < GamePiece

  def initialize(color)
    @name = "Bishop"
    @img = "♝"
    super color, @name, @img
  end

  def top_left_moves(row, col, board)
    moves = []
    current_row = row-1
    current_col = col-1
    current_cell = board[row][col]
    while move_inbounds?([current_row,current_col]) && cell_available(current_row, current_col, board)
      moves << [current_row, current_col]
      current_row -= 1
      current_col -= 1
    end
    add_move_if_enemy_piece_is_found(board, current_row, current_col, moves)
    moves
  end

  def top_right_moves(row, col, board)
    moves = []
    current_row = row-1
    current_col = col+1
    current_cell = board[row][col]
    while move_inbounds?([current_row,current_col]) && cell_empty?(current_row, current_col, board)
      moves << [current_row, current_col]
      current_row -= 1
      current_col += 1
    end
    add_move_if_enemy_piece_is_found(board, current_row, current_col, moves)
    moves
  end

  def bottom_left_moves(row, col, board)
    moves = []
    current_row = row+1
    current_col = col-1
    current_cell = board[row][col]
    while move_inbounds?([current_row,current_col]) && cell_available(current_row, current_col, board)
      moves << [current_row, current_col]
      current_row += 1
      current_col -= 1
    end
    add_move_if_enemy_piece_is_found(board, current_row, current_col, moves)
    moves
  end

  def bottom_right_moves(row, col, board)
    moves = []
    current_row = row+1
    current_col = col+1
    current_cell = board[row][col]
    while move_inbounds?([current_row,current_col]) && cell_available(current_row, current_col, board)
      moves << [current_row, current_col]
      current_row += 1
      current_col += 1
    end
    add_move_if_enemy_piece_is_found(board, current_row, current_col, moves)
    moves
  end

  def legal_moves(piece_coords =[], board)
    moves = []
    row = piece_coords[0]
    col = piece_coords[1]
    moves << top_left_moves(row, col, board)
    moves << top_right_moves(row, col, board)
    moves << bottom_left_moves(row, col, board)
    moves << bottom_right_moves(row, col, board)
    moves.flatten(1)
  end

end
