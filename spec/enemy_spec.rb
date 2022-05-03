require_relative "../lib/Enemy"
require_relative "../lib/Player"
require_relative "npc_shared_examples"

RSpec.describe Enemy do
  subject { Enemy.new(5, 1, 100) }
  include_examples "npc basic attributes"

  let(:inventory) { instance_double(Inventory, "Enemy Inv")}
  let(:player) { instance_double(Player, "Faker", health: 100,
    :health= => "ok") }

  context "enemy attributes" do

    it "has damage" do
      expect(subject).to have_attributes(damage: 5)
    end

    it "has armor" do
      expect(subject).to have_attributes(armor: 1)
    end

    it "has health" do
      expect(subject).to have_attributes(max_health: 100)
    end

    it "starts with an inventory" do
      expect(subject).to have_attributes(inventory: subject.inventory)
    end

    it "isn't dead on spawn" do
      expect(subject).to have_attributes(dead: false)
    end

    it "has a default map marker '@'" do
      expect(subject).to have_attributes(map_marker: "@")
    end

    it "has an image" do
      expect(subject).to have_attributes(image: subject.image)
    end

  end

  context "#deal_damage method" do
    it "reduces target's health" do
      expect(player).to receive(:health=).with(95)
      subject.deal_damage(player)
    end
  end
end