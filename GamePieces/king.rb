# frozen_string_literal: true

class King < GamePiece

  def initialize(color)
    @name = "King"
    @img = "♚"
    super color, @name,  @img
  end

end
