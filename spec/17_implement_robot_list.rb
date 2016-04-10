require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
  end

  it "once robot is created, it is in the @@robots array" do
    expect(Robot.robots).to include(@robot)
  end

end
