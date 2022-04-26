class Player
  attr_reader :id, :level, :image
  attr_accessor :name, :xp, :health, :damage, :armor, :pos_x, :pos_y, :quests, :dead, :quests, :inventory,
    :weapon, :abilities, :interacting_with, :map_marker

  def initialize
    @id = self.object_id
    @name = "Player"
    @level = 1
    @xp = 0
    @health = 100
    @damage = 1
    @armor = 1
    @pos_x = 0
    @pos_y = 0
    @dead = false
    @quests = []
    @inventory = []
    @equipped_weapon = ""
    @abilities = []
    @interacting_with = nil
    @map_marker = "#"
    @image = "A MLS image"
  end

end