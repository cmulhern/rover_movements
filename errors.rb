class Errors
  class InvalidMoveError < RuntimeError; end
  class InvalidStartingInfoError < RuntimeError; end
  class InvalidCommandError < RuntimeError; end
  class InvalidStartingGridCoordinates < TypeError; end
end

