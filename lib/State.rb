require_relative "../modules/Combat"
require_relative "../modules/Questing"
require_relative "../modules/Shopping"

module State

  def self.init(prompt = TTY::Prompt.new, reader = TTY::Reader.new,
    player = Player.new, map = Map.new
  )
    @prompt = prompt
    @reader = reader
    @player = player
    @map = map
  end

  def self.start
    system "cls"
    puts Text::RUBY_RPG
    @prompt.select("", cycle: true) do |menu|
      menu.choice "New Game", "new_game"
      menu.choice "Load Game", "load_game"
      menu.choice "About", "about"
      menu.choice "Quit", "quit"
    end
  end

  def self.menu
    system "cls"
    puts Text::MAIN_MENU
    selection = %w(Map Character Inventory Quests Quit)
    @prompt.select("Choose an action:", selection, cycle: true)
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
    puts Text::PLAYER
    puts "|Name||Level||Health||Gold||Damage||Armor||Weapon|"
    puts "#{@player.name}   #{@player.level}   #{@player.health}/#{@player.max_health}   #{@player.gold}    #{@player.damage}  #{@player.armor}    #{@player.equipped_weapon.name}"
    puts
    puts "Press any key to go back"
    @reader.read_keypress
    "Menu"
  end

  def self.inventory
    system "cls"
    puts Text::INVENTORY
    @player.inventory.each { |item| puts item.name }
    puts
    @prompt.select("Choose an action:") do |menu|
      menu.choice "Use"
      menu.choice "Equip"
      menu.choice "Go Back", "Menu"
    end
  end

  def self.use
    system "cls"
    consumables = @player.inventory.select { |item| item.is_a?(Consumable) }
    choices = consumables.map { |item| "#{item.name}   #{item.description}" }.push("Go Back")
    choice = @prompt.select("Use an item:", choices)
    unless choice == "Go Back"
      item = @player.inventory.find { |item| choice.include?(item.name) }
      item.affect(@player)
      @player.drop_item(item)
    end
    "Inventory"
  end

  def self.equip
    system "cls"
    weapons = @player.inventory.select { |item| item.is_a?(Weapon) }
    choices = weapons.map { |item| "#{item.name}   #{item.damage} DMG" }.push("Go Back")
    choice = @prompt.select("Equip a Weapon:", choices)
    unless choice == "Go Back"
      chosen_wep = @player.inventory.find { |item| choice.include?(item.name) }
      @player.equipped_weapon = chosen_wep
    end
    "Inventory"
  end

  def self.quests
    system "cls"
    puts Text::QUESTS
    puts "In progress:"
      if @player.unfinished_quests.length > 0
        @player.unfinished_quests.each { |quest| puts quest.name }
      else
        puts "You don't have any quests in progress."
      end
    puts
    puts "Finished:"
    if @player.finished_quests.length > 0
      @player.finished_quests.each { |quest| puts quest.name }
    else
      puts "You don't have any finished quests."
    end
    puts
    puts "Press any key to go back"
    @reader.read_keypress
    "Menu"
  end

  def self.finished_quest(quest)
    system "cls"
    puts "You have finished the quest '#{quest.name}'"
    puts
    puts "You have been rewarded with:"
    puts "#{quest.xp_reward} XP"
    puts "#{quest.gold_reward} Gold"
    quest.item_reward.each { |item| puts item.name }
    quest.finalize
    puts "Press any key to continue"
    @reader.read_keypress
  end

  def self.about
    puts "This is a Ruby RPG game"
    puts "Press any key to go back"
    @reader.read_keypress
  end

  def self.quit
    system "cls"
    puts Text::THANKS_FOR_PLAYING
    sleep 1
    system "cls"
    exit
  end
end