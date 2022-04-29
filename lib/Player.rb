require_relative "Inventory"

class Player
  attr_reader :id, :level, :image
  attr_accessor :name, :xp, :health, :damage, :armor, :pos_x, :pos_y, :quests, :dead, :inventory,
    :abilities, :interacting_with, :map_marker, :max_health, :gold, :equipped_weapon, :current_map

  def initialize
    @id = self.object_id
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
    @inventory = Inventory.new
    @equipped_weapon = Weapon.new
    @abilities = [Ability.new]
    @interacting_with = nil
    @map_marker = "#"
    @image = "A MLS image"
    @gold = 100
    @current_map = Map.new
  end

  def sell_item(item)
    @gold = @gold + item.price
    @inventory.remove(item)
  end

  def buy_item(item)
    if @gold >= item.price
      @gold = @gold - item.price
      @inventory.add(item)
    end
  end

  def drop_item(item)
    @inventory.remove(item)
  end

  def accept_quest(quest)
    @quests.push(quest)
  end

  def move_to(x, y)
    # Restrict moving out of map
    x = 0 if x < 0
    x = current_map.width if x > current_map.width
    y = 0 if y < 0
    y = current_map.height if y > current_map.height

    @pos_x, @pos_y = x, y

    # Check for interactions
    map_obj = @current_map.check(@pos_x, @pos_y)
    interact(map_obj) if map_obj.class == "Npc"
  end

  def interact(other)

  end

end