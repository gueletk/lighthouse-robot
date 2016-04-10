class PlasmaCannon < Weapon

DAMAGE = 55

  def initialize
    super("Plasma Cannon", 200, DAMAGE)
  end

  def hit(enemy_robot)
    enemy_robot.wound(DAMAGE)
  end

end
