class Inventory
  include Enumerable

  attr_reader :items

  def initialize
    @items = []
  end

  def each
    items.each do |item|
      yield item
    end
  end

  def include(item)
  end

  def add(item)
  end

  def delete(item)
  end

end