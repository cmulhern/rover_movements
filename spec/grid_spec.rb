require_relative 'spec_helper'

describe Grid do
  before :each do
      @fake_rover = double('rover')
      @fake_rover.stub(:xcoord).and_return(1)
      @fake_rover.stub(:ycoord).and_return(1)
      Rover.stub(:new).and_return(@fake_rover)
      @grid = Grid.new(["10 10", "1 1 E", "MMM"])
  end

  describe '#new' do

    it "takes an array of data and returns a grid object" do
     @grid.should be_instance_of Grid
    end

    it "initializes the rovers" do
      Rover.should_receive(:new).exactly(2)
      Grid.new(["10 10", "1 1 E", "MMM", "2 2 W", "LMRM"])
    end

    it "saves the location of the newly created rovers" do
      @fake_rover.should_receive(:xcoord).exactly(1)
      @fake_rover.should_receive(:ycoord).exactly(1)
      Grid.new(["10 10", "1 1 E", "MMM"])
    end

    it "raises an error if the grid coordinates are not integers" do
      expect {Grid.new(["10 asfds", "1 1 E", "MMM"])}.to raise_error(Errors::InvalidStartingGridCoordinates)
    end

  end

  describe '#update' do
    it "tells all rovers associated with the grid to move" do
      @fake_rover.should_receive(:make_moves)
      @grid.update
    end

    it "updates the location of the rover after being moved" do
      @fake_rover.stub(:make_moves)
      @fake_rover.should_receive(:xcoord).exactly(1)
      @fake_rover.should_receive(:ycoord).exactly(1)
      @grid.update
    end
  end

  describe '#valid_location?' do
    it "returns true if the coordinates are valid" do
      @grid.valid_location?(10, 10).should == true
    end

    it "returns false if the coordinates are invalid" do
      @grid.valid_location?(-1, 11).should == false
    end
  end

  describe '#print_locations' do
    it "prints the location of every rover associated with the grid"do
      @fake_rover.should_receive(:xcoord).exactly(1)
      @fake_rover.should_receive(:ycoord).exactly(1)
      @fake_rover.should_receive(:heading).exactly(1)
      @grid.print_locations
    end
  end
end
