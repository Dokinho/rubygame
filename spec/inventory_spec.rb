require_relative "../lib/Inventory"
require_relative "../lib/Item"

RSpec.describe Inventory do
  subject { Inventory.new(20) }

  let(:item1) { instance_double(Item, "1") }
  let(:item2) { instance_double(Item, "2") }
  let(:item3) { instance_double(Item, "3") }

  let(:inventar) { Inventory.new(15) }

  before do
    inventar.items = [item1, item2]
  end

  it { is_expected.to have_attributes(id: subject.object_id) }
  it { is_expected.to have_attributes(items: []) }
  it { is_expected.to have_attributes(max_slots: 20) }

  context "#add method" do
    it "adds an item to the inventory" do
      inventar.add(item3)
      expect(inventar.items).to eq([item1, item2, item3])
    end
  end

  context "#remove method" do
    it "removes an item from the inventory" do
      inventar.remove(item2)
      expect(inventar.items).to eq([item1])
    end
  end

  context "upgrade slots" do
    it "makes the inventory have more slots" do
      inventar.upgrade_slots(10)
      expect(inventar.max_slots).to eq(25)
    end
  end
end