require_relative 'spec_helper'

describe Robot do

  before :each do
    Robot.class_variable_set(:@@robots, [])
    @robot = Robot.new
    @robot2 = Robot.new
    @robot.equip_weapon(Mine.new)
  end

  it "can only use a Mine once" do
    @robot.attack(@robot2)
    expect(@robot.equipped_weapon).to eq(nil)
  end

end

describe Mine do

  before :each do
    Robot.class_variable_set(:@@robots, [])
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
    @robot4 = Robot.new
  end

  it "damages health of all robots around target by 30HP" do
    expect(@robot2).to receive(:position).at_least(:once).and_return([1,1])
    expect(@robot3).to receive(:position).at_least(:once).and_return([1,0])
    expect(@robot4).to receive(:position).at_least(:once).and_return([0,0])

    @robot.equip_weapon(Mine.new)
    @robot.attack(@robot4)

    expect(@robot2.health).to eq(70)
    expect(@robot3.health).to eq(70)
    expect(@robot4.health).to eq(70)
    expect(@robot.health).to eq(100)

  end

end
