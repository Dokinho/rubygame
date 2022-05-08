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

    @zloco = Enemy.new(10, 1, 50)
    @sef = Enemy.new(15, 3, 200)
    @vendor = Shop.new(10)
    @questodavac = QuestGiver.new
    @questodavac.quests << Quest.new("First quest!",
      "Kill an enemy!", 100, 200, [])

    # Items

    # Weapons
    @weapons = [
      Weapon.new("Sword", "Basic sword", 100, false, 1, "Common", 10, 1),
      Weapon.new("Dagger", "Basic dagger", 150, false, 1, "Common", 12, 1),
      Weapon.new("Mace", "Basic mace", 250, false, 1, "Common", 25, 1)
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
      Ability.new("Attack", "Basic attack", "-", "@owner.damage", "health")
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
    @igrac.add_ability(@abilities[0])

    # Add stuff to the shop
    @vendor.set_items(@weapons[1], @weapons[2], @consumables[0], @consumables[1])

    @prompt = TTY::Prompt.new(quiet: true)
    @reader = TTY::Reader.new
  end

  def self.start
    State.init(@prompt, @reader, @igrac, @mapa)
    choice = "Menu"
    loop do
      # Every State method should return a value with the same name as another State method
      choice = eval("State.#{choice.downcase}")
    end
  end

end

Game.setup
Game.start