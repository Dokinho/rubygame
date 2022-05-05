# To make bundler work
require "rubygems"
require "bundler/Setup"

require "tty-prompt"
require "tty-reader"

# Requires all files from "lib" folder
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

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

    @igrac.inventory.add(@weapons[0])
    @igrac.inventory.add(@consumables[0])
    @igrac.equipped_weapon = @weapons[0]

    # Abilities
    @abilities = [
      Ability.new("Attack", "Basic attack", "-", @igrac.damage, "health")
    ]

    @igrac.abilities << @abilities[0]

    # Map
    @mapa = Map.new("Mapa")

    # Add objects to map
    @mapa.add_object(@zloco, 6, 6)
    @mapa.add_object(@sef, 6, 8)
    @mapa.add_object(@vendor, 6, 5)
    @mapa.add_object(@questodavac, 6, 9)
    @mapa.add_object(@igrac, 13, 13)

    @prompt = TTY::Prompt.new(quiet: true)
    @reader = TTY::Reader.new
  end

  def self.start
    State.init(@prompt, @reader, @igrac, @mapa)
    choice = "Menu"
    loop do
      choice = eval("State.#{choice.downcase}")
    end
  end

end

Game.setup
Game.start