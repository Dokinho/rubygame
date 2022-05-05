require_relative "../modules/Combat"
require_relative "../modules/Questing"
require_relative "../modules/Shopping"

module State

  def self.init(prompt, reader, player, map)
    @prompt = prompt
    @reader = reader
    @player = player
    @map = map
  end

  def self.menu
    system "cls"
    selection = %w(Map Character Inventory Quests Quit)
    @prompt.select("-----MAIN MENU-----", selection, cycle: true)
  end

  def self.map
    system "cls"
    puts "-----Map legend-----"
    puts "# -> Player"
    puts "@ -> Enemy"
    puts "$ -> Shop"
    @map.render
    @prompt.select("Choose an action:", %w(Walk Menu), cycle: true )
  end

  def self.walk
    loop do

      system "cls"
      @map.render
      puts "WASD to move, Q to go back"
      input = @reader.read_keypress

      case input
      when "w"
        @map.move_object(@player, @player.pos_x - 1, @player.pos_y)
      when "s"
        @map.move_object(@player, @player.pos_x + 1, @player.pos_y)
      when "a"
        @map.move_object(@player, @player.pos_x, @player.pos_y - 1)
      when "d"
        @map.move_object(@player, @player.pos_x, @player.pos_y + 1)
      when "q"
        break
      end

      npc = @map.npc_collision_at(@player.pos_x, @player.pos_y)
      if npc
        @player.interacting_with = npc
        return "Interaction" 
      end

    end
    "Map"
  end

  def self.interaction
    case @player.interacting_with.class.to_s
    when "Enemy"
      fight_intro
    when "QuestGiver"
      questgiver_welcome
    when "Shop"
      shop_welcome
    else
      puts "Error! Going back to menu!"
      sleep 2
      return "Menu"
    end

    if @player.dead
      @player.respawn
      "Menu"
    else
    "Walk"
    end
  end

  def self.character
    system "cls"
    puts "-----Player-----"
    puts "|Name||Level||Health||Damage||Armor||Weapon|"
    puts "#{@player.name}   #{@player.level}   #{@player.health}/#{@player.max_health}    #{@player.damage}       #{@player.armor}    #{@player.equipped_weapon}"
    puts
    puts "Press any key to go back"
    @reader.read_keypress
    "Menu"
  end

  def self.inventory
    system "cls"
    @player.inventory.each { |item| puts item }
    puts
    puts "Press any key to go back"
    @reader.read_keypress
    "Menu"
  end

  def self.quests
    system "cls"
    @player.quests.each { |quest| puts quest.name }
    puts
    puts "Press any key to go back"
    @reader.read_keypress
    "Menu"
  end

  def self.quit
    system "cls"
    puts "Thanks for playing!"
    sleep 1
    exit
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