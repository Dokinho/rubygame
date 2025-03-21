require_relative "Saveable"

class Inventory
  include Enumerable
  include Saveable
  extend Saveable

  attr_reader :id, :max_slots
  attr_accessor :items

  def initialize(max_slots)
    @id = self.object_id
    @items = []
    @max_slots = max_slots
  end

  def each
    items.each do |item|
      yield item
    end
  end

  def add(item)
    @items << item
  end

  def remove(item)
    @items.delete(item)
  end

  def upgrade_slots(num)
    @max_slots += num
  end
end