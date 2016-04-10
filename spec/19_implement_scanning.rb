require_relative 'spec_helper'

describe Robot do

  before :each do
    Robot.class_variable_set(:@@robots, [])
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
  end

  it "returns a list of robots in a 1 tile range" do
    expect(@robot).to receive(:position).at_least(:once).and_return([0,1])
    expect(@robot2).to receive(:position).at_least(:once).and_return([1,1])
    expect(@robot3).to receive(:position).at_least(:once).and_return([0,1])
    expect(@robot.scan_surroundings).to match_array([@robot2, @robot3])
  end

  it "returns a list of robots that does not include robots further than a 1 tile range" do
    expect(@robot2).to receive(:position).at_least(:once).and_return([1,1])
    expect(@robot3).to receive(:position).at_least(:once).and_return([1,0])
    expect(@robot4).to receive(:position).at_most(:once).and_return([-1,0])

    expect(@robot.scan_surroundings).to match_array([@robot2, @robot3])
  end

end
