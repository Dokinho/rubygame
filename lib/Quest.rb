class Quest
  attr_reader :id, :name, :description, :xp_reward, :gold_reward, :item_reward

  def initialize(name, description, xp_reward = 0, gold_reward = 0, item_reward = [])
    @id = self.object_id
    @name = name.to_sym
    @description = description
    @xp_reward = xp_reward
    @gold_reward = gold_reward
    @item_reward = item_reward
  end

  def finish(player)
    player.xp += xp_reward if @xp_reward > 0
    player.gold += gold_reward if @gold_reward > 0
    @item_reward.each { |item| player.inventory.add(item) } if @item_reward.length > 0
  end
  
end