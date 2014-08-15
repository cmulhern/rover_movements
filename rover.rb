require_relative 'errors'
class Rover

  attr_reader :xcoord, :ycoord, :heading

  ###
  #Summary of variables:
  #xcoord and y coord are the current coordinates of the rover.
  #heading is the current direction of the rover.
  #moves is the string of moves provided by the input file.
  #number is the number of this rover.
  #grid is a reference to the grid that this rover is a part of.
  #
  #Expected input:
  #info is an array of strings where the first element is of the form "xcoord ycoord heading" and the second is the string of moves.
  #number is this rover's number.
  #grid is the Grid object that this rover is a part of.
  #
  #Errors:
  #InvalidStartingLocation raised if the starting coordinates are outside the bounds of the grid.
  #InvalidStartingHeading raised if the starting heading is not one of the four cardinal directions.
  ###

  def initialize(info, number, grid)
    valid_headings = ["N", "E", "S", "W"]
    begin
      location = info[0].split
      @xcoord, @ycoord = Integer(location[0]), Integer(location[1])
      @heading = location[2]
      @number = number
      @grid = grid

      raise Errors::InvalidStartingInfoError unless @grid.valid_location?(@xcoord, @ycoord) and valid_headings.include?(@heading)

    rescue Errors::InvalidStartingInfoError, TypeError
      puts "Invalid starting location (#{@xcoord}, #{@ycoord}) #{@heading} for rover ##{number}."
      @moves = nil

    else
      @moves = info[1].gsub(/\n/,"")
    end
  end

  #Processes the string of moves provided in the input.
  def make_moves
    if @moves != nil
      i = 0
      catch :invalid_command do
        @moves.each_char do |move|
          i += 1
          case move
            when "L"
              l_command
            when "R"
              r_command
            when "M"
              throw :invalid_command unless m_command(i)
            else  
              puts "Invalid move #{move} for rover ##{@number}"
              throw :invalid_command
          end
        end
      end
    end
  end

  #Determines the new direction the rover is facing after receiving a "L" command.
  def l_command
    @heading = case @heading
      when "N" then "W"
      when "E" then "N"
      when "S" then "E"
      when "W" then "S"
    end
  end

  #Determines the new direction the rover is facing after receiving a "R" command.
  def r_command
    @heading = case @heading
      when "N" then "E"
      when "E" then "S"
      when "S" then "W"
      when "W" then "N"
    end
  end

  #Attempts to move the rover forward depending on what direction it's currently facing. Asks the grid if the move would
  #be valid and raises an error if it is not.If there is an invalid move, the rover stops in its final valid position.
  def m_command(i)
    begin
      case @heading
        when "N"
          if !@grid.valid_location?(@xcoord, @ycoord + 1)
            raise Errors::InvalidMoveError
          else
            @ycoord += 1
          end
        when "E"
          if !@grid.valid_location?(@xcoord + 1, @ycoord)
            raise Errors::InvalidMoveError
          else
            @xcoord += 1
          end
        when "S"
          if !@grid.valid_location?(@xcoord, @ycoord - 1)
            raise Errors::InvalidMoveError
          else
            @ycoord -= 1
          end
        when "W"
          if !@grid.valid_location?(@xcoord - 1, @ycoord)
            raise Errors::InvalidMoveError
          else
            @xcoord -= 1
          end
      end
    rescue Errors::InvalidMoveError
      puts "Command ##{i} in rover ##{@number}'s command list causes it to drive off the edge. Halting execution of this rover."
      return false
    end
  end




end

