require_relative "../lib/Enemy"
require_relative "../lib/Player"
require_relative "../image_art/Image"
require_relative "npc_shared_examples"

RSpec.describe Enemy do
  subject { Enemy.new("Lopov", 10..15, 1, 100) }
  include_examples "npc basic attributes"

  let(:inventory) { instance_double(Inventory, "Enemy Inv")}
  let(:player) { instance_double(Player, "Faker", health: 100,
    :health= => "ok") }

  context "attributes" do

    it "has damage as a range" do
      expect(subject).to have_attributes(damage: 10..15)
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
      expect(subject).to have_attributes(image: Image::ENEMY_DEFAULT)
    end

  end

  context "#deal_damage" do

    it "reduces target's health" do
      expect(player).to receive(:health=).with(be >= 85 && be <= 90)
      subject.deal_damage(player)
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

end