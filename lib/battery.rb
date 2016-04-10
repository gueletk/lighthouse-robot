class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def charge(robot)
    robot.charge_shield(30)
  end

end
