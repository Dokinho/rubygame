require_relative "../lib/Quest"
require_relative "../lib/Player"
require_relative "../lib/Item"
require_relative "../lib/Inventory"

RSpec.describe Quest do
  subject { described_class.new("Test Quest", "A quest", 100, 200, [item1, item2]) }

  let(:quest_min_params) { described_class.new("Name", "Description") }

  let(:player) { instance_double(Player, "Playa", xp: 0, gold: 0,
    inventory: inventory) }

  let(:inventory) { instance_double(Inventory, "Player's inv", items: []) }

  let(:item1) { instance_double(Item, "Reward Item 1") }
  let(:item2) { instance_double(Item, "Reward Item 2") }

  context "with only name and description params" do

    it "has the specified name and description" do
      expect(quest_min_params).to have_attributes(name: :Name)
      expect(quest_min_params).to have_attributes(description: "Description")
    end

    it "has other attributes defaulted" do
      expect(quest_min_params).to have_attributes(xp_reward: 0)
      expect(quest_min_params).to have_attributes(gold_reward: 0)
      expect(quest_min_params).to have_attributes(item_reward: [])
    end

  end

  context "all params" do

    it { is_expected.to have_attributes(name: :"Test Quest") }
    it { is_expected.to have_attributes(description: "A quest") }
    it { is_expected.to have_attributes(xp_reward: 100) }
    it { is_expected.to have_attributes(gold_reward: 200) }

    it "has an item_reward attribute that must be an array (of items)" do
      expect(subject.item_reward).to be_a_kind_of(Array)
      expect(subject).to have_attributes(item_reward: [item1, item2])
    end

  end

  context "#finish" do
    # it "gets called when the quest requirements are met" do

    # end

    it "rewards the player with quest rewards" do
      expect(player).to receive(:xp=).with(100)
      expect(player).to receive(:gold=).with(200)
      expect(player.inventory).to receive(:add).with(item1)
      expect(player.inventory).to receive(:add).with(item2)

      subject.finish(player)
    end
  end

end