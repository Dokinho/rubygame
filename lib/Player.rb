require_relative "Inventory"
require_relative "Ability"

class Player
  attr_reader :id, :level, :image
  attr_accessor :name, :xp, :health, :damage, :armor, :pos_x, :pos_y, :quests, :dead, :inventory,
    :abilities, :interacting_with, :map_marker, :max_health, :gold, :equipped_weapon

  def initialize
    @name = "Player"
    @level = 1
    @xp = 0
    @health = 100
    @max_health = 100
    @damage = 1
    @armor = 1
    @pos_x = 0
    @pos_y = 0
    @dead = false
    @quests = []
    @inventory = Inventory.new(10)
    @equipped_weapon = nil
    @abilities = []
    @interacting_with = nil
    @map_marker = "#"
    @image = "A MLS image"
    @gold = 100
  end

  def sell_item(item)
    @gold = @gold + item.price
    @inventory.remove(item)
    "You have sold #{item.name}"
  end

  def buy_item(item)
    if @gold >= item.price
      @gold = @gold - item.price
      @inventory.add(item)
      "You have bought #{item.name}"
    else
      "You don't have enough gold!"
    end
  end

  def drop_item(item)
    @inventory.remove(item)
  end

  def accept_quest(quest)
    @quests.push(quest)
  end
end