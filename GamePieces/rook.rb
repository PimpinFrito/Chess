# frozen_string_literal: true

require_relative 'game_piece'

class Rook < GamePiece

  def initialize(color)
    name = "Rook"
    img = "♜"
    if color == "White"
      @possible_moves = [[-1, 0]]
    else
      @possible_moves = [[1, 0]]
    end
    super color, name, img
  end


  def legal_moves(piece_coords =[], board)
    moves = []
    moves << get_horizontal_moves(piece_coords, board)
    moves << get_vertical_moves(piece_coords, board)
    moves.flatten 1
  end

  def get_horizontal_moves(piece_coords=[], board)
    row = piece_coords[0]
    current_column = piece_coords[1] - 1
    moves = []
    #Get left side
    until board[row][current_column].is_a?(GamePiece) || current_column < 0
      moves.push([row, current_column])
      current_column-= 1
    end

    #Get right side
    current_column = piece_coords[1] +1
    until board[row][current_column].is_a?(GamePiece) || current_column >=COL_SIZE
      moves.push([row, current_column])
      current_column += 1
    end
    p moves
    moves
  end

  def get_vertical_moves(piece_coords, board)
    column = piece_coords[1]
    current_row = piece_coords[0] + 1
    moves = []

    #Get Bottom side
    until current_row >= ROW_SIZE ||
      (board[current_row][column].is_a?(GamePiece) && board[current_row][column].get_color == get_color)
      moves.push([current_row, column])
      current_row += 1
      p moves
    end

    #Get Top side
    current_row = piece_coords[0] - 1
    until current_row < 0 || board[current_row][column].is_a?(GamePiece)
      moves.push([current_row, column])
      current_row -= 1
    end
    moves
  end


end

# rook = Rook.new("White", [7,0] )
# board = Board.new
# p rook.legal_moves([4,0], board.get_rows)