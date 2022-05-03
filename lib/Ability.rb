class Ability
  attr_reader :name, :description, :type, :attribute
  attr_accessor :amount

  def initialize(name, description, type, amount, attribute)
    @name = name
    @description = description
    @type = type
    @amount = amount
    @attribute = attribute
  end

  def activate(target)
    str = "target.#{@attribute} #{@type}= #{@amount}"
    eval(str)
  end
end