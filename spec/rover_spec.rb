require_relative 'spec_helper'

describe Rover do
  before :each do
    @grid = double('Grid')
    @grid.stub(:valid_location?).and_return(true)
    @rover = Rover.new(["1 1 E", "MMML"], 1, @grid)
  end

  describe '#new' do

    it "creates a new rover object" do

      @rover.should be_instance_of Rover
    end

    it "should ignore all moves if the starting location is invalid" do
      @grid.stub(:valid_location?).and_return(false)
      @rover = Rover.new(["1 -4 E", "MMM"], 1, @grid)
      @rover.instance_variable_get(:@moves).should be_nil
    end

    it "should ignore all moves if the starting heading is invalid" do
      @rover = Rover.new(["1 1 T", "MMM"], 1, @grid)
      @rover.instance_variable_get(:@moves).should be_nil
    end
  end

  describe '#make_moves' do
    it "executes a series of moves" do
      @rover.make_moves
      @rover.instance_variable_get(:@xcoord).should == 4
      @rover.instance_variable_get(:@ycoord).should == 1
      @rover.instance_variable_get(:@heading).should == "N"
    end
  end
  describe '#m_command' do
    it "executes all M moves" do
      @rover = Rover.new(["1 1 E", "M"], 1, @grid)
      @rover.m_command(1)
      @rover.instance_variable_get(:@xcoord).should == 2
      @rover.instance_variable_get(:@ycoord).should == 1
    end
  end
  describe '#l_command' do
    it "executes all L moves" do
      @rover = Rover.new(["1 1 E", "L"], 1, @grid)
      @rover.l_command
      @rover.instance_variable_get(:@heading).should == "N"
    end
  end
  describe '#r_command' do
    it "executes all R moves" do
      @rover = Rover.new(["1 1 E", "R"], 1, @grid)
      @rover.r_command
      @rover.instance_variable_get(:@heading).should == "S"
    end
  end

end
