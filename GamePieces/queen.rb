# frozen_string_literal: true

class Queen < GamePiece

  def initialize(color)
    #init a bishop and rook to get legal moves for queen
    @bishop_moves = Bishop.new(color)
    @rook_moves = Rook.new(color)
    @name = "Queen"
    @img =  "♛"
    super color, @name,@img
  end

  def legal_moves(piece_coords =[], board)
    moves = []
    moves <<  @bishop_moves.legal_moves(piece_coords, board)
    moves << @rook_moves.legal_moves(piece_coords, board)
    moves.flatten(1)
  end

end
