require_relative "../lib/Player"
require_relative "../lib/Weapon"
require_relative "../lib/Ability"

RSpec.describe Player do
  let(:player) { described_class.new }

  let(:default_weapon) { double(Weapon) }

  let(:abilitet) { double(Ability) }

  context "instantiated" do

    it "has an 'id' equal to its object_id" do
      expect(player).to have_attributes(id: player.object_id)
    end
  
    it "has a default name of 'Player'" do
      expect(player).to have_attributes(name: "Player")
    end
  
    it "should start with level 1" do
      expect(player).to have_attributes(level: 1)
    end
  
    it "should start with 0 xp" do
      expect(player).to have_attributes(xp: 0)
    end
  
    it "should start with 100 health points" do 
      expect(player).to have_attributes(health: 100)
    end
  
    it "should start with 1 damage" do
      expect(player).to have_attributes(damage: 1)
    end
  
    it "should start with 1 armor" do
      expect(player).to have_attributes(armor: 1)
    end
  
    it "has a default x position on the map of 0" do
      expect(player).to have_attributes(pos_x: 0)
    end
  
    it "has a default y position on the map of 0" do
      expect(player).to have_attributes(pos_y: 0)
    end
  
    it "should not be dead" do
      expect(player).to have_attributes(dead: false)
    end
  
    it "has quests as an empty array" do
      expect(player).to have_attributes(quests: [])
    end
  
    it "has an inventory as an empty array" do
      expect(player).to have_attributes(inventory: [])
    end
  
    it "should have a default equipped weapon" do
      expect(player).to have_attributes(equipped_weapon: default_weapon)
    end
  
    it "should have an array of abilities and a default attack ability" do
      expect(player).to have_attributes(abilities: [abilitet])
    end
  
    it "should not be interacting with anything" do
      expect(player).to have_attributes(interacting_with: nil)
    end
  
    it "has a default map marker" do
      expect(player).to have_attributes(map_marker: "#")
    end
  
    it "has a default ASCII image" do
      expect(player).to have_attributes(image: "A MLS image")
    end

  end

end

  # subject do
  #   described_class.new(id: 0, name: "Drc", level: 0, xp: 0, health: 100,
  #   damage: 10, armor: 2, pos_x: 0, pos_y: 0, dead: false, quests: [],
  #   inventory: [], equipped_weapon: "Mac", abilities: [], interacting_with: "obj",
  #   map_marker: "#", image: "Player MLS")
  # end