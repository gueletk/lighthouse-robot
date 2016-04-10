require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
    @battery = Battery.new
  end

  it "will add Battery to inventory if shield is above 20" do
    @robot.pick_up(@battery)
    expect(@robot.items).to include(@battery)
  end

  context "if the shield is more than 30 points depleted" do

    it "will not add the Battery to @items" do
      expect(@robot).to receive(:shield).and_return(0)
      @robot.pick_up(@battery)
      expect(@robot.items).not_to include(@battery)
    end

    it "will use the Battery to charge shield" do
      expect(@robot).to receive(:shield).and_return(0)
      expect(@battery).to receive(:charge)
      @robot.pick_up(@battery)
    end
  end

end

describe Battery do

  before :each do
    @robot = Robot.new
    @battery = Battery.new
  end

  it "is a Battery" do
    expect(@battery.is_a?(Battery)).to eq(true)
  end

  it "has a weight of 25" do
    expect(@battery.weight).to eq(25)
  end

end
