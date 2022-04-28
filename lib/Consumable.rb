require_relative "Item"

class Consumable < Item
  attr_reader :type, :amount, :attribute

  def initialize(name, description, price, stackable, stack_count, rarity,
    type, amount, attribute)

    super(name, description, price, stackable, stack_count, rarity)
    @type = type
    @amount = amount
    @attribute = attribute
  end

  def affect(target)
    str = "target.#{@attribute} #{@type}= #{@amount}"
    eval(str)
  end
end