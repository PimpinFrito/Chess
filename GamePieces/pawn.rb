# frozen_string_literal: true
require_relative 'game_piece'

class Pawn < GamePiece

  # def initialize(color, starting_coords)
  #   super color
  #   @starting_coords = starting_coords
  # end
  def initialize(color, starting_coords)
    name = "Pawn"
    img = "♟"
    super color, name, img
    @starting_coords = starting_coords

  end

  def legal_moves(piece_coords = nil, board)
    row = piece_coords[0]
    col = piece_coords[1]
    forward_move = @color == WHITE ? -1 : 1
    moves = []
    #Forward moves
    if cell_empty?( row+forward_move, col, board)
      standard_move = [row + forward_move, col]
      moves << standard_move
      first_move_double = forward_move + forward_move
      #If it's the pawns first move and the spaces 2 cells ahead isn't occupied
      if @starting_coords == piece_coords && cell_empty?(row + first_move_double, col, board)
        double_move = row + first_move_double
        moves.push([double_move,col])
      end
    end
    #Diagonal moves for enemies
    add_move_if_enemy_piece_is_found(board, row+forward_move, col-1, moves)
    add_move_if_enemy_piece_is_found(board, row+forward_move, col+1, moves)
    moves
  end

end
