require_relative "Npc"
require_relative "Quest"

class QuestGiver < Npc
  attr_accessor :quests, :map_marker, :image, :greeting, :goodbye

  def initialize()
    super()
    @quests = []
    @map_marker = "?"
    @image = Image::QUESTGIVER_DEFAULT
    @greeting = "Hello there!"
    @goodbye = "Goodbye!"
  end

end