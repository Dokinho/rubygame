require_relative "Npc"
require_relative "Inventory"

class Enemy < Npc
  attr_reader :damage, :dead, :map_marker, :image, :max_health
  attr_accessor :armor, :health, :inventory

  def initialize(damage, armor, max_health)
    super()
    @damage = damage
    @armor = armor
    @max_health = max_health
    @health = max_health
    @inventory = Inventory.new(5)
    @dead = false
    @map_marker = "@"
    @image = "image"
  end

  def deal_damage(target)
    target.health -= damage
  end
end