class Mine < Weapon

  def initialize
    super("Mine", 40, 30, 1)
  end

  def hit(enemy_robot, attacker)
    enemy_robot.scan_surroundings.each do |robot|
      robot.direct_wound(30) unless robot == attacker
    end
    enemy_robot.direct_wound(30)
  end

end
