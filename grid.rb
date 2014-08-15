require_relative 'rover'
require_relative 'errors'
class Grid

  ###
  #Summary of variables:
  #grid is a 2d array of all objects on the plateau.
  #rovers is an array of all rovers on the plateau.
  #
  #Expected input:
  #data is an array of strings. The first element is the max cell of the grid and every subsequent pair of elements is info
  #for a rover.
  def initialize(data)
    begin
      coords = data.shift.split
      raise Errors::InvalidStartingGridCoordinates unless coords.length == 2
      rovers = data.each_slice(2).to_a
      raise Errors::InvalidStartingGridCoordinates unless coords[0] =~/^-?(\d+(\.d.d+)?|\.\d+)$/ and coords[1] =~ /^-?(\d+(\.d.d+)?|\.\d+)$/
      @cols, @rows = coords[0].to_i + 1, coords[1].to_i + 1
      @grid = Array.new(@rows) {Array.new(@cols)}
      @rovers = []
      i = 0
      rovers.each {|rover|
        i += 1
        new_rover = (Rover.new(rover, i, self))
        @grid[new_rover.xcoord][new_rover.ycoord] = new_rover
        @rovers.push(new_rover)
      }

    end
  end

  #Iterates through all rovers associated with this grid to have them make their moves.
  def update
      @rovers.each {|rover|
        rover.make_moves
        @grid[rover.xcoord][rover.ycoord] = rover
      }
  end

  #Determines if the given coordinate pair falls within the boundaries of the grid.
  def valid_location?(xcoord, ycoord)
    if xcoord.between?(0,@cols - 1) and ycoord.between?(0, @rows - 1)
      return true
    else
      return false
    end
  end

  #Prints the location of all rovers associated with this grid.
  def print_locations
      @rovers.each {|rover|
        puts "#{rover.xcoord} #{rover.ycoord} #{rover.heading}"
      }
  end

end

