require_relative "../lib/QuestGiver"
require_relative "npc_shared_examples"

RSpec.describe QuestGiver do
  subject { QuestGiver.new }

  include_examples "npc basic attributes"

  context "specific attributes" do

    it "has an array of quests" do
      expect(subject).to have_attributes(quests: [])
    end

    it "has a default map marker" do
      expect(subject).to have_attributes(map_marker: "?")
    end

    it "has a default greeting message for the player" do
      expect(subject).to have_attributes(greeting: "Hello there!")
    end

    it "has a default goodbye message for the player" do
      expect(subject).to have_attributes(goodbye: "Goodbye!")
    end

  end
end