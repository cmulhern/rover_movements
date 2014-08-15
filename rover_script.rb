require_relative 'grid'

#Script to run the program.
begin
  raise "Invalid file type" unless File.extname(ARGV[0]) == ".txt"


  grid = Grid.new(IO.readlines(ARGV[0]))
  grid.update
  grid.print_locations


end







