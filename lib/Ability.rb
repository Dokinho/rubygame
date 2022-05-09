class Ability
  attr_reader :name, :description, :type, :attribute
  attr_accessor :amount, :owner

  def initialize(name, description, type, amount, attribute)
    @name = name.to_sym
    @description = description
    @type = type
    @amount = amount
    @attribute = attribute
    @owner = nil
  end

  def activate(target)
    actual_amount = eval(@amount)
    str = "target.#{@attribute} #{@type}= #{actual_amount}"
    eval(str)
    actual_amount
  end 

  def crit(chance)
    # Ability should take another optional parameter for special stuff, for example crit
    # Crit should have a chance to return a bigger "amount" to be used in "activate"
  end
end