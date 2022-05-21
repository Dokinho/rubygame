require_relative "Enemy"
require_relative "Saveable"

class Quest
  include Saveable

  attr_reader :name, :description, :conditions, :xp_reward, :gold_reward,
    :item_reward, :owner, :starting

  def initialize(name, description, conditions, xp_reward = 0, gold_reward = 0,
    item_reward = []
  )
    @name = name.to_sym
    @description = description
    @conditions = conditions
    @xp_reward = xp_reward
    @gold_reward = gold_reward
    @item_reward = item_reward
    @owner = nil
    @starting = {
      enemy_deaths: 0,
      level: 0
    }
  end

  def finalize
    # Give rewards
    @owner.xp += xp_reward if @xp_reward > 0
    @owner.gold += gold_reward if @gold_reward > 0
    @item_reward.each { |item| @owner.inventory.add(item) } if @item_reward.length > 0

    # Tell owner to move the quest into finished quests array
    @owner.finish_quest(self)
  end

  def is_finished?
    conditions.all? { |condition| eval(condition) }
  end

  def accepted_by(player)
    @owner = player
    @starting[:enemy_deaths] = Enemy.deaths
    @starting[:level] = @owner.level
  end
end