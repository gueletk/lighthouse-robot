require 'byebug'
class Robot

  attr_reader :x, :y, :items, :health, :shield
  attr_accessor :equipped_weapon

  DEFAULT_ATTACK = 5
  @@robots = []

  def initialize
    @x = 0
    @y = 0
    @items = []
    @health = 100
    @shield = 50
    @@robots << self
  end

  def self.in_position(x_coord,y_coord)
    @@robots.select do |robot|
      robot.position == [x_coord,y_coord]
    end
  end

  def self.robots
    @@robots
  end

  def scan_surroundings
    nearby_robots = []
    for x_coord in (x - 1)..(x + 1)
      for y_coord in (y - 1)..(y + 1)
        current_tile = self.class.in_position(x_coord, y_coord)
        nearby_robots << current_tile if current_tile != []
      end
    end
    nearby_robots.flatten! - [self]
  end

  def pick_up(item)
    if items_weight + item.weight <= 250
      if item.kind_of?(Weapon)
        equip_weapon(item)
      elsif item.is_a?(Battery)
        if shield <= 20
          item.charge(self)
        else
          @items << item
        end
      else
        case item.name
        when "Box of bolts"
          if health <= 80
            item.feed(self)
          else
            @items << item
          end
        else
          @items << item
        end
      end
    end
  end

  def equip_weapon(weapon)
    @equipped_weapon = weapon
  end

  def charge_shield(energy)
    @shield += energy
  end

  def direct_wound(attack_strength)
    if health - attack_strength >= 0
      @health -= attack_strength
    else
      @health = 0
    end
  end

  def wound(attack_strength)
    if shield > attack_strength
      @shield -= attack_strength
      attack_strength = 0
    elsif shield > 0
      attack_strength -= shield
      @shield = 0
    end
    direct_wound(attack_strength)
  end

  def heal(health_points)
    if health + health_points <=100
      @health += health_points
    else
      @health = 100
    end
  end

  def within_range?(robot)
    x_dist = (@x - robot.position[0]).abs
    y_dist = (@y - robot.position[1]).abs
    x_dist <= range && y_dist <= range
  end

  def attack(enemy_robot)
    if within_range?(enemy_robot)
      if @equipped_weapon
        case @equipped_weapon.name
        when "Grenade"
          @equipped_weapon.hit(enemy_robot)
          @equipped_weapon = nil
        when "Mine"
          @equipped_weapon.hit(enemy_robot,self)
          @equipped_weapon = nil
        else
          @equipped_weapon.hit(enemy_robot)
        end

      else
        enemy_robot.wound(DEFAULT_ATTACK)
      end
    end
  end

  def range
    if equipped_weapon
      return equipped_weapon.range
    else
      return 1
    end
  end

  def items_weight
    total_weight = 0
    @items.each do |item|
      total_weight += item.weight
    end
    total_weight
  end

  def position
    [x, y]
  end

  def move_left
    @x -= 1
  end

  def move_right
    @x += 1
  end

  def move_up
    @y += 1
  end

  def move_down
    @y -= 1
  end
end
