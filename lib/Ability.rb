class Ability
  attr_reader :name, :description, :type, :attribute
  attr_accessor :amount

  def initialize(name, description, type, amount, attribute)
    @name = name.to_sym
    @description = description
    @type = type
    @amount = amount
    @attribute = attribute
  end

  def activate(target)
    str = "target.#{@attribute} #{@type}= #{@amount}"
    eval(str)
  end 

  def crit(chance)
    # Ability should take another optional parameter for special stuff, for example crit
    # Crit should have a chance to return a bigger "amount" to be used in "activate"
  end
end