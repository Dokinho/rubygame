require_relative "Npc"
require_relative "Quest"

class QuestGiver < Npc
    attr_accessor :quests

  def initialize()
    super()
    @quests = []
  end

end