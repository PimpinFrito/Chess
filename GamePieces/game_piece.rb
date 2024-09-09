# frozen_string_literal: true

class GamePiece
  ROW_SIZE = 8
  COL_SIZE = 8
  @name = nil
  @color = nil
  WHITE = "White"
  BLACK = "Black"


  # def initialize(color)
  #   @color = color
  # end
  #

  #For testing
  def initialize(color, name, img)
    # Raise an error if any required argument is nil or empty
    raise ArgumentError, 'Color must be provided' if color.nil? || color.empty?
    raise ArgumentError, 'Name must be provided' if name.nil? || name.empty?
    raise ArgumentError, 'Img of game piece must be provided' if img.nil? || !img.is_a?(String)

    @color = color
    @name = name
    @img = @color == WHITE ? "\033[97m#{img}" : "\033[30m#{img}"
  end

  def to_s
    " #{@img} "
  end


  def get_color
    @color

  end

  def get_name
    @name
  end

  def legal_moves(piece_coords =[], board)
    raise StandardError, "Not overridden"
    # legal_moves = []
    # row_size = board_size[0]
    # col_size = board_size[1]
    # @possible_moves.each do | move |
    #   possible_row = piece_coords[0] + move[0]
    #   possible_col = piece_coords[1] + move[1]
    #   #If possible_row and column aren't outside the bounds
    #   # then add to legal move list
    #   if possible_row <= row_size && possible_col <= col_size && possible_row >= 0 && possible_col >= 0
    #     legal_moves.push [possible_row, possible_col]
    #   end
    # end
    # legal_moves
  end

  def move_inbounds?(move = [])
    possible_row = move[0]
    possible_col = move[1]
    possible_row <= ROW_SIZE && possible_col <= COL_SIZE && possible_row >= 0 && possible_col >= 0
  end
end
