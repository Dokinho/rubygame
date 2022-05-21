require_relative "Inventory"
require_relative "Ability"
require_relative "Saveable"

class Player
  include Saveable

  attr_reader :id, :level, :image, :equipped_weapon, :health, :mana, :gold,
    :unfinished_quests, :finished_quests
  attr_accessor :name, :xp, :base_damage, :damage, :armor, :pos_x, :pos_y, :dead,
    :inventory, :abilities, :interacting_with, :map_marker, :max_health, :max_mana

  def initialize
    @name = "Player"
    @level = 1
    @xp = 0
    @health = 100
    @max_health = 100
    @mana = 100
    @max_mana = 100
    @base_damage = 1..5
    @damage = 1..5
    @armor = 1
    @pos_x = 0
    @pos_y = 0
    @dead = false
    @unfinished_quests = []
    @finished_quests = []
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
    @equipped_weapon = nil if item == @equipped_weapon
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
    @unfinished_quests.push(quest)
    quest.accepted_by(self)
  end

  def finish_quest(quest)
    @finished_quests << quest
    @unfinished_quests.delete(quest)
  end

  def equipped_weapon=(weapon)
    if weapon.nil?
      @damage = @base_damage
    else
      @damage = weapon.damage
    end
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

  def mana=(mana)
    if mana > max_mana
      @mana = max_mana
    elsif mana <= 0
      @mana = 0
    else
      @mana = mana
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

  # This should be used instead of manually adding abilities to Player
  # because it sets the owner of the ability automatically
  def add_ability(ability)
    @abilities << ability
    ability.owner = self
  end

  def quests
    unfinished_quests | finished_quests
  end
end