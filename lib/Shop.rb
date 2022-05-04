require_relative "Npc"
require_relative "Inventory"

class Shop < Npc
  attr_accessor :inventory, :greeting, :goodbye

  def initialize(slots)
    super()
    @inventory = Inventory.new(slots)
    @map_marker = "$"
    @greeting = "Welcome to the shop!"
    @goodbye = "Come back again soon!"
  end

  def set_items(*items)
    items.each { |item| @inventory.add(item) }
  end

end