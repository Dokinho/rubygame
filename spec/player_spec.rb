require_relative "../lib/Player"
require_relative "../lib/Weapon"
require_relative "../lib/Ability"
require_relative "../lib/Consumable"
require_relative "../lib/Item"
require_relative "../lib/Quest"
require_relative "../lib/Inventory"
require_relative "../lib/Map"
require_relative "../lib/NPC"

RSpec.describe Player do

  let(:player) { described_class.new }

  let(:weapon) { instance_double(Weapon, "Default Weapon") }

  let(:ability) { instance_double(Ability, "Attack") }

  let(:consumable) { instance_double(Consumable, "Eat me") }

  let(:item) { instance_double(Item, "Wep or potion") }

  let(:quest) { instance_double(Quest, "Test Quest") }

  let(:inventory) { instance_double(Inventory, "Player's inventory",
    remove: nil, add: nil) }

  let(:map) { instance_double(Map, "Test Map", width: 200, height: 150) }

  let(:npc) { instance_double(Npc, "Enemy", pos_x: 10, pos_y: 10,
    interact: "start_interaction") }

  before do
    allow(Weapon).to receive(:new).and_return(weapon)
    allow(Ability).to receive(:new).and_return(ability)
    allow(Consumable).to receive(:new).and_return(consumable)
    allow(Item).to receive(:new).and_return(item)
    allow(Quest).to receive(:new).and_return(quest)
    allow(Inventory).to receive(:new).and_return(inventory)
    allow(Map).to receive(:new).and_return(map)
  end

  context "instantiated" do
  
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
      expect(player).to have_attributes(max_health: 100)
    end
  
    it "should start with 1 base damage" do
      expect(player).to have_attributes(base_damage: 1)
    end

    it "should have total damage equal to its base damage" do
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
  
    it "has quests as an empty array (of quests)" do
      expect(player).to have_attributes(quests: [])
    end
  
    it "has an inventory" do
      expect(player).to have_attributes(inventory: inventory)
    end
  
    it "should have an equipped weapon attribute" do
      expect(player).to have_attributes(equipped_weapon: nil)
    end
  
    it "should have an array of abilities" do
      expect(player).to have_attributes(abilities: [])
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

    it "has got starting gold of 100" do
      expect(player).to have_attributes(gold: 100)
    end

  end

  context "actions:" do

    let(:weapon) { instance_double(Weapon, "Another Weapon", damage: 10) }

    let(:item) { instance_double(Item, "Another Item", price: 50,
      name: "Itemmm")
    }

    context "sell an item" do

      it "takes an item as an argument" do
        expect(player).to receive(:sell_item).with(item)
        player.sell_item(item)
      end

      it "adds gold to the player" do
        expect { player.sell_item(item) }.to change { player.gold }.by(item.price)
      end

      it "removes the item from player's inventory" do
        expect(player.inventory).to receive(:remove).with(item)
        player.sell_item(item)
      end

    end

    context "buy an item" do

      it "takes an item as an argument" do
        expect(player).to receive(:buy_item).with(item)
        player.buy_item(item)
      end

      it "removes gold from the player" do
        expect { player.buy_item(item) }.to change { player.gold }.by(-item.price)
      end

      it "adds the item to player's inventory" do
        expect(player.inventory).to receive(:add).with(item)
        player.buy_item(item)
      end

    end

      it "drop an item" do
        expect(player).to receive(:drop_item).with(item)
        
        player.drop_item(item)
      end

    context "respawn" do
      
      it "refills health" do
        expect(player.health).to eq(player.max_health)
      end

      it "resets player's position" do
        expect(player.pos_x).to eq(0)
        expect(player.pos_y).to eq(0)
      end

    end

    it "accept a quest" do
      player.accept_quest(quest)
      expect(player.quests).to include(quest)
    end

    context "#equipped_weapon=" do

      it "modifies player's equipped weapon attribute" do
        player.equipped_weapon = weapon
        expect(player.equipped_weapon).to eq(weapon)
      end

      it "modifies player's damage attribute" do
        player.equipped_weapon = weapon
        expect(player.damage).to eq(11)
      end
  
    end

    context "#health=" do

      it "sets 'dead' to true if health is less than or equal to 0" do
        subject.health=(-5)
        expect(subject.dead).to be_truthy
      end
  
      it "sets 'health' to 0 if health is less than 0" do
        subject.health=(-10)
        expect(subject.health).to eq(0)
      end
  
    end

    context "#respawn" do

      it "resets the player's coordinates" do
        player.respawn
        expect(player).to have_attributes(pos_x: 0, pos_y: 0)
      end

      it "resets player's health" do
        player.respawn
        expect(player.health).to eq(player.max_health)
      end

      it "makes the player lose some gold" do
        expect { player.respawn }.to change {player.gold}
      end

      it "sets 'dead' back to false" do
        player.dead = true
        expect(player.dead).to be_truthy
        
        player.respawn
        expect(player.dead).to be_falsy
      end

    end

    context "#gold=" do

      it "sets player's gold to a value" do
        player.gold = 350
        expect(player.gold).to eq(350)
      end

      it "sets gold to 0 if it goes below 0" do
        player.gold = -100
        expect(player.gold).to eq(0)
      end

    end

  end
end