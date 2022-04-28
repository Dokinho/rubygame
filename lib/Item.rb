class Item
  attr_reader :id, :name, :description, :price, :stackable, :rarity
  def initialize(name, description, price, stackable, rarity)
    @id = object_id
    @name = name
    @description = description
    @price = price
    @stackable = stackable
    @rarity = rarity
  end
end