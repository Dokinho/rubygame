require_relative "Npc"
require_relative "Inventory"

class Shop < Npc
  attr_accessor :inventory

  def initialize(slots)
    super()
    @inventory = Inventory.new(slots)
    @map_marker = "$"
  end

  def set_items(*items)
    items.each { |item| @inventory.add(item) }
  end

end