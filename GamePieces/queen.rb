# frozen_string_literal: true

class Queen < GamePiece

  def initialize(color)
    @name = "Queen"
    @img =  "♛"
    super color, @name,@img
  end
end
