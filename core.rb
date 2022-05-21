require "time"
require "json"

# To make bundler work
require "rubygems"
require "bundler/Setup"

# TTY
require "tty-prompt"
require "tty-reader"

# Requires all files from "lib" folder
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

# Include game art
require_relative "image_art/Image"
require_relative "image_art/Text"

class Game
  # Load defaults
  def self.setup
    # Items

    # Weapons
    @weapons = [
      Weapon.new("Sword", "Basic sword", 100, false, 1, "Common", 10..15, 1),
      Weapon.new("Dagger", "Basic dagger", 150, false, 1, "Common", 12..16, 1),
      Weapon.new("Mace", "Basic mace", 250, false, 1, "Common", 13..20, 1)
    ]

    # Consumables
    @consumables = [
      Consumable.new("Health Potion", "Restores 20 health points", 25,
        true, 10, "Common", "+", 20, "health"),
      Consumable.new("Damage boost potion", "Doubles your damage", 40,
        true, 5, "Common", "*", 2, "damage")
    ]

    # Abilities
    @abilities = [
      Ability.new("Attack", "Basic attack", "other - rand(@owner.damage) health"),
      Ability.new("Heal", "Heals for 30 HP", "self + 30 health", 30, "Player healed for 30 HP")
    ]

    # Quests
    @quests = [
      Quest.new("Getting started", "Kill an enemy!",
        ["Enemy.deaths > @starting[:enemy_deaths]"], 100, 100, []
      ),
      Quest.new("More = Better", "Level up!",
        ["@owner.level > @starting[:level]"], 0, 200, [@weapons[1]]
      ),
      Quest.new("Getting even higher", "Reach level 5",
      ["@owner.level > 5"], 0, 500, [])
    ]

    # Map
    @mapa = Map.new("Mapa")
  end

  def self.new_game
    self.setup

    # Player and NPCs
    @igrac = Player.new
    @igrac.name = State.create_character

    @zloco = Enemy.new("Lopov", 5..10, 1, 50)
    @sef = Enemy.new("Boss", 10..20, 3, 200)
    @vendor = Shop.new(10)
    @questodavac = QuestGiver.new
    @npcs = [@zloco, @sef, @vendor, @questodavac]

    # Add objects to map
    # Player is added last so it will be rendered when it's on top of something else
    @mapa.add_object(@zloco, 6, 6)
    @mapa.add_object(@sef, 6, 8)
    @mapa.add_object(@vendor, 6, 5)
    @mapa.add_object(@questodavac, 6, 9)
    @mapa.add_object(@igrac, 0, 0)

    # Add stuff to player
    @igrac.inventory.add(@weapons[0])
    3.times { @igrac.inventory.add(@consumables[0]) }
    @igrac.equipped_weapon = @weapons[0]
    @abilities.each { |ability| @igrac.add_ability(ability) }

    # Add stuff to the shop
    @vendor.set_items(@weapons[1], @weapons[2], @consumables[0], @consumables[1])

    # Add quests to the questgiver
    @quests.each { |quest| @questodavac.quests << quest }
  end

  def self.save_game(filename)
    File.open("./save/#{filename}.json", "w") do |file|
      player_hash = @igrac.to_hash_with_id
      npc_hashes = @npcs.map { |npc| npc.to_hash_with_id }
      wep_hashes = @weapons.map { |wep| wep.to_hash_with_id}
      cons_hashes = @consumables.map { |cons| cons.to_hash_with_id}
      ability_hashes = @abilities.map { |ability| ability.to_hash_with_id}
      quest_hashes = @quests.map { |quest| quest.to_hash_with_id}
      map_hash = @mapa.to_hash_with_id

      data = {
        player: player_hash,
        npcs: npc_hashes,
        weapons: wep_hashes,
        consumables: cons_hashes,
        abilities: ability_hashes,
        quests: quest_hashes,
        map: map_hash
      }
      JSON.dump(data, file)
    end
  end

  def self.load_game(filename)
    puts "Loading"
  end

  def self.start
    @prompt = TTY::Prompt.new(quiet: true)
    @reader = TTY::Reader.new

    State.init(@prompt, @reader)
    #Start of the game loop (main menu)
    loop do
      choice = State.start
      case choice
      when "new_game"
        self.new_game
        break
      when "load_game"
        self.new_game
        break
      when "about" then State.about
      when "quit" then State.quit
      end
    end

    # Main game loop - when New Game or Load Game is selected
    State.init(@prompt, @reader, @igrac, @mapa)
    choice = "Menu"
    loop do
      # Checks if any of player's quests are finished before anything so it can display
      # a "pop-up" message
      @igrac.unfinished_quests.each { |quest| State.finished_quest(quest) if quest.is_finished? }

      # Every State method should return a value with the same name as another State method
      choice = eval("State.#{choice.downcase}")
    end
  end

end

Game.start
# Game.load_game("Player")