# frozen_string_literal: true

class Knight < GamePiece

  def initialize(color)
    @name = "Knight"
    @img = "♞"
    if color == "White"
      @possible_moves = [[-1, 0]]
    else
      @possible_moves = [[1, 0]]
    end
    super color, @name, @img
  end

  # def legal_moves(piece_coords =[], board)
  #
  # end

end
