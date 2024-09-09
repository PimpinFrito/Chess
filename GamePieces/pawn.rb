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
    move = @color = WHITE ? -1 : 1
    standard_move = [piece_coords[0] + move, piece_coords[1]]
    moves = [standard_move]
    if @starting_coords == piece_coords
      first_move_double = move + move
      double_move = piece_coords[0] + first_move_double
      moves.push([double_move,piece_coords[1]])
    end
    p moves
    moves
  end

end
