require_relative "../lib/Player"
require_relative "../lib/Weapon"
require_relative "../lib/Ability"
require_relative "../lib/Consumable"
require_relative "../lib/Item"
require_relative "../lib/Quest"
require_relative "../lib/Inventory"

RSpec.describe Player do

  let(:player) { described_class.new }

  let(:weapon) { instance_double(Weapon, "Default Weapon") }
  let(:abilitet) { instance_double(Ability, "Attack") }
  let(:consumable) { instance_double(Consumable, "Eat me") }
  let(:item) { instance_double(Item, "Wep or potion") }
  let(:quest) { instance_double(Quest, "Test Quest") }
  let(:inventory) { instance_double(Inventory, "Player's inventory") }

  before do
    allow(Weapon).to receive(:new).and_return(weapon)
    allow(Ability).to receive(:new).and_return(abilitet)
    allow(Consumbale).to receive(:new).and_return(consumable)
    allow(Item).to receive(:new).and_return(item)
    allow(Quest).to receive(:new).and_return(quest)
    allow(Inventory).to receive(:new).and_return(inventory)
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
  
    context "has an inventory" do

      it "as an instance of the Inventory class" do
        expect(player).to have_attributes(inventory)
      end

      it "that is empty" do
        expect(player.inventory.length).to eq(0)  
      end

    end
  
    it "should have a default equipped weapon" do
      expect(player).to have_attributes(equipped_weapon: weapon)
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

    it "has got starting gold of 100" do
      expect(player).to have_attributes(gold: 100)
    end

  end

  context "actions:" do

    let(:weapon) { instance_double(Weapon, "Another Weapon") }
    let(:item) { instance_double(Item, "Item") }

    it "equip a weapon" do
      expect(player).to receive(:equip_weapon).with(weapon)
      expect(player).to have_attributes(equipped_weapon: weapon)
      player.equip_weapon(weapon)
    end

    it "use an item (consumable)" do
      expect(player).to receive(:use_item).with(consumable)
      player.use_item(consumable)
    end

    context "sell an item" do

      it "takes an item as an argument" do
        expect(player).to receive(:sell_item).with(item)
        player.sell_item
      end

      it "adds gold to the player" do
        expect { player.sell_item(item) }.to change { player.gold }.by(item.price)
      end

      it "removes the item from player's inventory" do
        expect(player.inventory).not_to include(item)
        player.sell_item
      end

    end

    context "buy an item" do

      it "takes an item as an argument" do
        expect(player).to receive(:buy_item).with(item)
        player.buy_item
      end

      it "removes gold from the player" do
        expect { player.buy_item(item) }.to change { player.gold }.by(-item.price)
      end

      it "adds the item to player's inventory" do
        expect(player.inventory).to include(item)
        player.buy_item
      end

    end

    it "drop an item, deleting it forever" do
      expect(player).to receive(:drop_item).with(item)
      expect(player.inventory).not_to include (item)

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

    it "accept a quest - add a quest to player's quest array" do
      expect(player).to receive(:accept_quest).with(quest)
      expect(player.quests).to include(quest)
    end

    it "move to certain coordinates" do
      expect { player.move_to }.to change { player.pos_x }
      expect { player.move_to }.to change { player.pos_y }
    end

    it "can die" do
      expect(player).to receive(die)
    end

    it 'interact' do
      expect(player).to receive(interact)
    end

  end

end

  # subject do
  #   described_class.new(id: 0, name: "Drc", level: 0, xp: 0, health: 100,
  #   damage: 10, armor: 2, pos_x: 0, pos_y: 0, dead: false, quests: [],
  #   inventory: [], equipped_weapon: "Mac", abilities: [], interacting_with: "obj",
  #   map_marker: "#", image: "Player MLS")
  # end