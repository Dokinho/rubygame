require_relative "../lib/Quest"
require_relative "../lib/Player"
require_relative "../lib/Item"
require_relative "../lib/Inventory"
require_relative "../lib/Enemy"

RSpec.describe Quest do
  subject { described_class.new("Test Quest", "A quest", ["true"], 100, 200,
    [item1, item2])
  }

  let(:unfinished_quest) { described_class.new("Quest 2", "Desc", ["false"]) }

  let(:quest_min_params) { described_class.new("Name", "Description", ["condition"]) }

  let(:player) { instance_double(Player, "Playa", xp: 0, gold: 0,
    inventory: inventory, level: 1, finish_quest: nil, :xp= => nil,
    :gold= => nil) }

  let(:inventory) { instance_double(Inventory, "Player's inv", items: [], add: nil) }

  let(:item1) { instance_double(Item, "Reward Item 1") }
  let(:item2) { instance_double(Item, "Reward Item 2") }

  context "with only name, description and conditions params" do
    it "has the specified name, description and conditions" do
      expect(quest_min_params).to have_attributes(name: :Name)
      expect(quest_min_params).to have_attributes(description: "Description")
      expect(quest_min_params).to have_attributes(conditions: ["condition"])
    end

    it "has other attributes defaulted" do
      expect(quest_min_params).to have_attributes(id: quest_min_params.object_id)
      expect(quest_min_params).to have_attributes(xp_reward: 0)
      expect(quest_min_params).to have_attributes(gold_reward: 0)
      expect(quest_min_params).to have_attributes(item_reward: [])
    end
  end

  context "all params" do
    it { is_expected.to have_attributes(name: :"Test Quest") }
    it { is_expected.to have_attributes(description: "A quest") }
    it { is_expected.to have_attributes(conditions: ["true"]) }
    it { is_expected.to have_attributes(xp_reward: 100) }
    it { is_expected.to have_attributes(gold_reward: 200) }

    it "has an item_reward attribute that must be an array (of items)" do
      expect(subject.item_reward).to be_a_kind_of(Array)
      expect(subject).to have_attributes(item_reward: [item1, item2])
    end
  end

  context "#finalize" do
    before do
      subject.accepted_by(player)
    end

    it "rewards the player with quest rewards" do
      expect(player).to receive(:xp=).with(100)
      expect(player).to receive(:gold=).with(200)
      expect(player.inventory).to receive(:add).with(item1)
      expect(player.inventory).to receive(:add).with(item2)
      subject.finalize
    end

    it "moves the quest to player's finished quests array" do
      expect(player).to receive(:finish_quest).with(subject).exactly(1).times
      subject.finalize
    end
  end

  context "#is_finished?" do
    it "returns true if all quest conditions are met" do
      expect(subject.is_finished?).to be_truthy
      expect(unfinished_quest.is_finished?).to be_falsy
    end
  end

  context "#accepted_by" do
    it "sets its owner" do
      subject.accepted_by(player)
      expect(subject.owner).to eq(player)
    end

    it "sets the starting counters for tracking" do
      subject.accepted_by(player)
      expect(subject.starting[:enemy_deaths]).to eq(0)
      expect(subject.starting[:level]).to eq(1)
    end
  end

end