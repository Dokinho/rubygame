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
    delete: nil, add: nil) }

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
      expect(player).to have_attributes(max_health: 100)
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
  
    it "has quests as an empty array (of quests)" do
      expect(player).to have_attributes(quests: [])
    end
  
    it "has an inventory" do
      expect(player).to have_attributes(inventory: inventory)
    end
  
    it "should have a default equipped weapon" do
      expect(player).to have_attributes(equipped_weapon: weapon)
    end
  
    it "should have an array of abilities and a default attack ability" do
      expect(player).to have_attributes(abilities: [ability])
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

    let(:weapon) { instance_double(Weapon, "Another Weapon") }
    let(:item) { instance_double(Item, "Another Item", price: 50) }

    it "equip a weapon" do
      expect(player).to receive(:equipped_weapon=).with(weapon)
      expect(player).to have_attributes(equipped_weapon: weapon)

      player.equipped_weapon = weapon
    end

    it "use an item (consumable)" do
      expect(player).to receive(:use_item).with(consumable)
      player.use_item(consumable)
    end

    context "sell an item" do

      it "takes an item as an argument" do
        expect(player).to receive(:sell_item).with(item)
        player.sell_item(item)
      end

      it "adds gold to the player" do
        expect { player.sell_item(item) }.to change { player.gold }.by(item.price)
      end

      # it "removes the item from player's inventory" do
      #   expect(player.inventory).not_to include(item)
      #   player.sell_item(item)
      # end

    end

    context "buy an item" do

      it "takes an item as an argument" do
        expect(player).to receive(:buy_item).with(item)
        player.buy_item(item)
      end

      it "removes gold from the player" do
        expect { player.buy_item(item) }.to change { player.gold }.by(-item.price)
      end

      # it "adds the item to player's inventory" do
      #   expect(player.inventory).to include(item)
      #   player.buy_item(item)
      # end

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

    context "#move_to" do
      before do
        allow(map).to receive(:check).with(any_args).and_return(nil)
        allow(map).to receive(:check).with(npc.pos_x, npc.pos_y).and_return(npc)
      end

      it "moves player to given coordinates on the map" do
        expect { player.move_to(10, 15) }.to change { player.pos_x }.to(10)
        expect { player.move_to(3, 20) }.to change { player.pos_y }.to(20)
      end

      it "forbids the player from going out of the map" do
        player.move_to(-1, -1)
        expect(player.pos_x).to eq(0)
        expect(player.pos_y).to eq(0)

        player.move_to(map.width + 100, map.height + 100)
        expect(player.pos_x).to eq(map.width)
        expect(player.pos_y).to eq(map.height)
      end

    end

    context "#interact" do
      it "is called by the #move_to method if an NPC is encountered on the map" do
      end
      
    end

  end

end

  # subject do
  #   described_class.new(id: 0, name: "Drc", level: 0, xp: 0, health: 100,
  #   damage: 10, armor: 2, pos_x: 0, pos_y: 0, dead: false, quests: [],
  #   inventory: [], equipped_weapon: "Mac", abilities: [], interacting_with: "obj",
  #   map_marker: "#", image: "Player MLS")
  # end