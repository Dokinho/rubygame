require "tty-prompt"
require "tty-reader"

require_relative "Map"
require_relative "Player"

module State
  @igrac = Player.new
  @mapa = Map.new("Mapa", 20, 20)
  @mapa.add_object(@igrac, 0, 1)

  @prompt = TTY::Prompt.new
  @reader = TTY::Reader.new

  # The main loop is located here
  def self.menu
    loop do
      system "cls"
      selection = %w(Map Character Inventory Quests Quit)
      choice = @prompt.select("-----MAIN MENU-----", selection)

      case choice
      when "Map"
        self.map
      when "Character"
        self.character
      when "Inventory"
        self.inventory
      when "Quests"
        self.quests
      when "Quit"
        system "cls"
        puts "Thanks for playing!"
        sleep 1
        exit
      else
        puts "Stop cheating!"
      end
    end
  end

  def self.map
    system "cls"
    puts "-----Map legend-----"
    puts "# -> Player"
    puts "& -> Enemy"
    puts "$ -> Shop"
    @mapa.render
    choice = @prompt.select("Choose an action:", %w(Walk Back) )
    case choice
    
    when "Walk"
      loop do
        system "cls"
        @mapa.render
        input = @reader.read_keypress
        case input
        when "w"
          @mapa.move_object(@igrac, @igrac.pos_x - 1, @igrac.pos_y)
        when "s"
          @mapa.move_object(@igrac, @igrac.pos_x + 1, @igrac.pos_y)
        when "a"
          @mapa.move_object(@igrac, @igrac.pos_x, @igrac.pos_y - 1)
        when "d"
          @mapa.move_object(@igrac, @igrac.pos_x, @igrac.pos_y + 1)
        when "q"
          break
        end
      end
    end

  end

  def self.character
    system "cls"
    puts "LIK"
  end

  def self.inventory
    system "cls"
    puts "INVENTAR"
  end

  def self.quests
    system "cls"
    puts "KVESTOVI"
  end

  def self.combat
    system "cls"
    puts "BORBA"
  end

  def self.shop
    system "cls"
    puts "ŠOPING"
  end
  
end