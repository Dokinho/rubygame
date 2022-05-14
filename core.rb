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

  def self.setup
    # Player and NPCs
    @igrac = Player.new

    @zloco = Enemy.new("Lopov", 5..10, 1, 50)
    @sef = Enemy.new("Boss", 10..20, 3, 200)
    @vendor = Shop.new(10)
    @questodavac = QuestGiver.new

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

    @prompt = TTY::Prompt.new(quiet: true)
    @reader = TTY::Reader.new
  end

  def self.start
    State.init(@prompt, @reader, @igrac, @mapa)
    choice = "Menu"
    loop do
      # Checks if any of player's quest are finished before anything
      @igrac.unfinished_quests.each { |quest| State.finished_quest(quest) if quest.is_finished? }

      # Every State method should return a value with the same name as another State method
      choice = eval("State.#{choice.downcase}")
    end
  end

end

Game.setup
Game.start