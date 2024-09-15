# frozen_string_literal: true

class Knight < GamePiece

  def initialize(color)
    name = "Knight"
    img = "♞"
    super color, name, img
  end

  def vertical_moves(row, col, board)
    moves = []
    current_row = row
    current_col = col
    #top side
    # up 2 left and right 1
    current_row -= 2
    if move_inbounds?([current_row,current_col])
      moves << [current_row, current_col - 1 ] if cell_available(current_row, current_col-1, board)
      moves << [current_row, current_col + 1 ] if cell_available(current_row, current_col+1, board)
    end

    #bottom side
    # down 2 left and right 1
    current_row = row + 2
    # p "Starting row col: [#{row}, #{col}]"
    # puts "Current row and col: [#{current_row}, #{current_col}]"
    if move_inbounds?([current_row,current_col])
      moves << [current_row, current_col - 1 ] if cell_available(current_row, current_col-1, board)
      moves << [current_row, current_col + 1 ] if cell_available(current_row, current_col+1, board)
    end
    moves

  end

  def horizontal_moves(row, col, board)
    moves = []
    current_row = row
    current_col = col
    #col left 2 up and down 1
        p "Starting row col: [#{row}, #{col}]"
        puts "Current row and col: [#{current_row}, #{current_col}]"
    current_col = col - 2
    if move_inbounds?([current_row,current_col])
      moves << [current_row - 1, current_col] if cell_available(current_row-1, current_col, board)
      moves << [current_row + 1, current_col] if cell_available(current_row+1, current_col, board)
    end

    #col right 2 up and down 1
    current_col = col + 2
    if move_inbounds?([current_row,current_col])
      moves << [current_row - 1, current_col] if cell_available(current_row-1, current_col, board)
      moves << [current_row + 1, current_col] if cell_available(current_row+1, current_col, board)
    end
    moves
  end

  def legal_moves(piece_coords =[], board)
    row = piece_coords[0]
    col = piece_coords[1]
    moves = []
    moves << vertical_moves(row, col, board)
    moves << horizontal_moves(row, col, board)
    moves.flatten(1)

  end

end
