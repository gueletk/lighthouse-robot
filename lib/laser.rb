class Laser < Weapon

DAMAGE = 25

  def initialize
    super("Laser", 125, DAMAGE)
  end

  def hit(enemy_robot)
    enemy_robot.wound(DAMAGE)
  end

end
