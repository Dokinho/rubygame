require_relative "Saveable"

class Npc
  include Saveable
  extend Saveable

  attr_accessor :pos_x, :pos_y, :map_marker, :image
  attr_reader :id, :name

  def initialize(name = "NPC name", x = 0, y = 0)
    @id = self.object_id
    @name = name
    @pos_x = x
    @pos_y = y
    @map_marker = "*"
    @image = Image::NPC_DEFAULT
  end

  def interact()
    "Interacting"
  end
end