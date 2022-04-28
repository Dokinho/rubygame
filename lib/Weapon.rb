require_relative "Item"

class Weapon < Item
  attr_reader :damage, :req_lvl

  def initialize(name, description, price, stackable, stack_count, rarity,
    damage, req_lvl)

    super(name, description, price, stackable, stack_count, rarity)
    @damage = damage
    @req_lvl = req_lvl
  end
end