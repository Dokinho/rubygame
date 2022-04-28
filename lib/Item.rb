class Item
  attr_accessor :price
  def initialize(name, price)
    @id = object_id
    @name = name
    @price = price
  end
end