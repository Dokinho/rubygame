require_relative "Saveable"

class Item
  include Saveable
  extend Saveable

  attr_reader :id, :name, :description, :price, :stackable, :stack_count, :rarity
  
  def initialize(name, description, price, stackable, stack_count, rarity)
    @id = self.object_id
    @name = name
    @description = description
    @price = price
    @stackable = stackable
    @stack_count = stack_count
    @rarity = rarity
  end
end