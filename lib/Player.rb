require_relative "Inventory"
require_relative "Ability"

class Player
  attr_reader :id, :level, :image, :equipped_weapon, :health, :gold
  attr_accessor :name, :xp, :base_damage, :damage, :armor, :pos_x, :pos_y, :quests,
  :dead, :inventory, :abilities, :interacting_with, :map_marker, :max_health

  def initialize
    @name = "Player"
    @level = 1
    @xp = 0
    @health = 100
    @max_health = 100
    @base_damage = 1
    @damage = base_damage
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
    @image = Image::PLAYER_DEFAULT
    @gold = 100
  end

  def sell_item(item)
    @gold = @gold + item.price
    @inventory.remove(item)
    @damage = @base_damage if item == equipped_weapon
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

  def equipped_weapon=(weapon)
    @damage = @base_damage + weapon.damage
    @equipped_weapon = weapon
  end

  def health=(health)
    if health > max_health
      @health = max_health
    elsif health <= 0
      @health = 0
      @dead = true
    else
      @health = health
    end
  end

  def respawn
    @pos_x, @pos_y = 0, 0
    @health = @max_health
    @gold -= 200
    @dead = false
  end

  def gold=(gold)
    (gold < 0) ? @gold = 0 : @gold = gold
  end

end