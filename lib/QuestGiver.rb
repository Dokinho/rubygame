require_relative "Npc"
require_relative "Quest"

class QuestGiver < Npc
    attr_accessor :quests, :map_marker

  def initialize()
    super()
    @quests = []
    @map_marker = "?"
  end

  def display_quests
    @quests.each { |quest| puts quest }
  end

end