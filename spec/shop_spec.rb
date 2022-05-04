require_relative "../lib/Shop"
require_relative "../lib/Item"
require_relative "npc_shared_examples"

RSpec.describe Shop do
  subject { Shop.new(5) }

  before do
    allow(Inventory).to receive(:new).and_return(inventory)
  end

  let(:item1) { instance_double(Item, "Mac") }
  let(:item2) { instance_double(Item, "Noz") }
  let(:item3) { instance_double(Item, "Health Potion") }

  let(:inventory) { instance_double(Inventory, "Shop Inventory",
    items: [item1], add: nil) }

  include_examples "npc basic attributes"

  context "specific attributes" do

    it { is_expected.to have_attributes(inventory: inventory) }
    
    it "should start with an inventory of a given size" do
      expect(Inventory).to receive(:new).with(10)  
      Shop.new(10)
    end

    it { is_expected.to have_attributes(map_marker: "$") }

    it { is_expected.to have_attributes(greeting: "Welcome to the shop!") }

    it { is_expected.to have_attributes(goodbye: "Come back again soon!") }

  end

  context "#set_items" do
    it "adds items to the shop by calling its inventory function" do
      expect(inventory).to receive(:add).with(item2)
      expect(inventory).to receive(:add).with(item3)
      subject.set_items(item2, item3)
    end
  end
  
end