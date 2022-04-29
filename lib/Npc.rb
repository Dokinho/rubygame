class Npc
    attr_accessor :pos_x, :pos_y
    attr_reader :id, :name

    def initialize(name = "NPC name", x = 0, y = 0)
        @id = object_id
        @name = name
        @pos_x = x
        @pos_y = y
    end

    def interact()
        "Interacting"
    end
end