require_relative "Npc"
require_relative "Inventory"

class Enemy < Npc
  attr_reader :damage, :dead, :map_marker, :image
  attr_accessor :armor, :health, :inventory

  def initialize(damage, armor, health)
    super()
    @damage = damage
    @armor = armor
    @health = health
    @inventory = Inventory.new(5)
    @dead = false
    @map_marker = "@"
    @image = "image"
  end

  def deal_damage(target, amount)
    target.health -= amount
  end
end