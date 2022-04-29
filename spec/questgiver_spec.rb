require_relative "../lib/QuestGiver"
require_relative "npc_shared_examples"

RSpec.describe QuestGiver do
  subject { QuestGiver.new }

  include_examples "npc basic attributes"

  context "specific attributes" do
    it "has an array of quests" do
      expect(subject).to have_attributes(quests: [])
    end
  end

  context "#display_quests" do
    it "displays all of its quests" do
    end
  end
end