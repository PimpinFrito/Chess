# frozen_string_literal: true

class Bishop < GamePiece

  def initialize(color)
    @name = "Bishop"
    @img = "♝"
    super color, @name, @img
  end

  def legal_moves(piece_coords =[], board)
    moves = []
    moves << top_left_moves(piece_coords =[], board)
    moves << top_right_moves(piece_coords =[], board)
    moves << bottom_left_moves(piece_coords =[], board)
    moves << bottom_right_moves(piece_coords =[], board)
  end

end
