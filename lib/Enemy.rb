require_relative "Npc"
require_relative "Inventory"

class Enemy < Npc
  attr_reader :damage, :dead, :map_marker, :image, :max_health
  attr_accessor :armor, :health, :inventory

  def initialize(name, damage, armor, max_health)
    super(name)
    @damage = damage
    @armor = armor
    @max_health = max_health
    @health = max_health
    @inventory = Inventory.new(5)
    @dead = false
    @map_marker = "@"
    @image = Image::ENEMY_DEFAULT
  end

  def deal_damage(target)
    amount = rand(@damage)
    target.health -= amount
    amount
  end

  def health=(health)
    if health <= 0
      @health = 0
      @dead = true
    else
      @health = health
    end
  end
end