require_relative 'spec_helper'

describe Robot do

  before :each do
     Robot.class_variable_set(:@@robots, [])
  end

  it "Robot.in_position(x,y) returns an array of all robots in that position" do
    @robot = Robot.new
    @robot.move_up
    expect(Robot.in_position(0,1)).to include(@robot)
  end

  it "Robot.in_position(x,y) returns an array of all robots in that position (works for more than one robot)" do
    @robot = Robot.new
    @robot2 = Robot.new
    @robot.move_up
    @robot2.move_up
    expect(Robot.in_position(0,1)).to include(@robot2)
  end

end
