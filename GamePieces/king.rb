# frozen_string_literal: true

class King < GamePiece

  def initialize(color)
    @name = "King"
    @img = "♚"
    super color, @name,  @img
  end

  def legal_moves(piece_coords = [], board)
    moves = []
    row = piece_coords[0]
    col = piece_coords[1]
    #Move sideways
    moves << [row, col-1] if cell_available(row, col-1, board)
    moves << [row, col+1] if cell_available(row, col-1, board)

    #From white side, up, top left and top right
    moves << [row-1, col-1] if cell_available(row-1, col-1, board)
    moves << [row-1, col] if cell_available(row-1, col, board)
    moves << [row-1, col+1] if cell_available(row-1, col+1, board)
    #From white side, down, bottom left and bottom right
    moves << [row+1, col-1] if cell_available(row+1, col-1, board)
    moves << [row+1, col] if cell_available(row+1, col, board)
    moves << [row+1, col+1] if cell_available(row+1, col+1, board)

    moves
  end

end
