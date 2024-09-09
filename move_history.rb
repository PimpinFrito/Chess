# frozen_string_literal: true

class MoveHistory
  def initialize(startingPosition, endingPosition, player, pieceTaken)
    #TODO throw error if starting ending or player is nil
    # piece taken isn't necessary
    @starting_position = startingPosition
    @ending_position = endingPosition
    @player = player
    @piece_taken = pieceTaken
  end
  def getMovement
    [@starting_position, @ending_position, @player]
  end

  def getStartingPosition
    @starting_position
  end
  def getEndingPosition
    @ending_position
  end

end
