require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
  end

  it "should start with 50 shield points" do
    expect(@robot.shield).to eq(50)
  end

  it "@health should not decrease when attacked and shield > 0" do
    @enemy_robot = Robot.new
    @enemy_robot.attack(@robot)
    expect(@robot.health).to eq(100)
  end

  it "@shield should decrease when attacked" do
    @enemy_robot = Robot.new
    @enemy_robot.attack(@robot)
    expect(@robot.shield).to eq(45)
  end

  it "if the hit is larger than the shield, it decreases the hit points by the remainder" do
    @enemy_robot = Robot.new
    stub_const("Robot::DEFAULT_ATTACK", 100)
    @enemy_robot.attack(@robot)
    expect(@robot.health).to eq(50)
  end

  it "if the hit is larger than the shield, it decreases the shield points to 0" do
    @enemy_robot = Robot.new
    stub_const("Robot::DEFAULT_ATTACK", 100)
    @enemy_robot.attack(@robot)
    expect(@robot.shield).to eq(0)
  end

end
