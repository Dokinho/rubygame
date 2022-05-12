class Ability
  attr_reader :name, :description, :target, :sign, :attribute, :mana_cost, :message
  attr_accessor :amount, :owner

  # Ability effects should be written a certain way:
  # effect = "target sign amount attribute"
  #
  #   target = self or other
  #   sign = + - * /
  #   amount = a number or anything that evaluates to a number
  #   attribute = target's variable name that it affects
  #
  # Example 1: effect = "self + 30 health" will add 30 health to ability's owner upon activation
  # Example 2: effect = "other - rand(@owner.damage) health" will reduce @owner.interacting_with's health
  #   by owner's damage
  
  def initialize(name, description, effect, mana_cost = 0, message = "")
    @name = name.to_sym
    @description = description
    @target, @sign, @amount, @attribute = effect.split
    @mana_cost = mana_cost
    @owner = nil
    @message = message
  end

  def activate
    if @owner.mana >= @mana_cost
      actual_amount = eval(@amount)
      actual_target = @target == "self" ? @owner : @owner.interacting_with
      str = "actual_target.#{@attribute} #{@sign}= #{actual_amount}"
      eval(str)
      @owner.mana -= @mana_cost if @mana_cost > 0
      true
    else
      false
    end
  end

  def crit(chance)
    # Ability should take another optional parameter for special stuff, for example crit
    # Crit should have a chance to return a bigger "amount" to be used in "activate"
  end
end