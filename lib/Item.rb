class Item
  attr_reader :id, :name, :description, :price, :stackable, :stack_count, :rarity
  
  def initialize(name, description, price, stackable, stack_count, rarity)
    @name = name
    @description = description
    @price = price
    @stackable = stackable
    @stack_count = stack_count
    @rarity = rarity
  end
end