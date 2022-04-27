class Player
  attr_reader :id, :level, :image, :equipped_weapon
  attr_accessor :name, :xp, :health, :damage, :armor, :pos_x, :pos_y, :quests, :dead, :quests, :inventory,
    :abilities, :interacting_with, :map_marker, :abilities

  def initialize
    @id = self.object_id
    @name = "Player"
    @level = 1
    @xp = 0
    @health, max_health = 100, 100
    @damage = 1
    @armor = 1
    @pos_x = 0
    @pos_y = 0
    @dead = false
    @quests = []
    @inventory = []
    @equipped_weapon = Weapon.new
    @abilities = [Ability.new]
    @interacting_with = nil
    @map_marker = "#"
    @image = "A MLS image"
  end

  private

  def equip_weapon(weapon)
    @equipped_weapon = weapon
  end

end