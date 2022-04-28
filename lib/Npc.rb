class Npc
    attr_accessor :pos_x, :pos_y

    def initialize()
        @pos_x = 10
        @pos_y = 10
    end

    def interact()
        "Interacting"
    end
end