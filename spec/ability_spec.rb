require_relative "../lib/Ability"
require_relative "../lib/Enemy"
require_relative "../lib/Player"

RSpec.describe Ability do
  subject { Ability.new("Attack", "Basic attack", "other - 10 health") }

  let(:heal) { Ability.new("Heal", "Heals the player for 10 HP",
    "self + 10 health", 30, "Player healed for 10 HP") }

  let(:bad_guy) { instance_double(Enemy, "Bad Guy", health: 100) }

  let(:good_guy) { instance_double(Player, "Good Guy", health: 100,
    :health= => nil, mana: 100, :mana= => nil, interacting_with: bad_guy) }

  let(:good_guy_no_mana) { instance_double(Player, "Manaless", health: 100,
    :health= => "ok", mana: 0, name: "Manaless") }

  context "attributes" do
    it { is_expected.to have_attributes(name: :Attack) }
    it { is_expected.to have_attributes(description: "Basic attack") }
    it { is_expected.to have_attributes(target: "other") }
    it { is_expected.to have_attributes(sign: "-") }
    it { is_expected.to have_attributes(amount: "10") }
    it { is_expected.to have_attributes(attribute: "health") }
    it { is_expected.to have_attributes(mana_cost: 0) }
    it { is_expected.to have_attributes(owner: nil) }
    it { is_expected.to have_attributes(message: "") }
  end

  context "#activate" do

    context "owner has enough mana" do
      before do
        subject.owner = good_guy
        heal.owner = good_guy
      end

      it "changes the target's attributes" do
        expect(bad_guy).to receive(:health=).with(90).exactly(1).times
        subject.activate
      end

      it "reduces owner's mana by its mana cost" do
        expect(good_guy).to receive(:mana=).with(70).exactly(1).times
        heal.activate
      end

      it "returns true to signal that the spell has been activated" do
        message = heal.activate
        expect(message).to be_truthy
      end
    end

    context "owner does not have enough mana" do
      before do
        heal.owner = good_guy_no_mana
      end

      it "no attributes should be affected" do
        expect(good_guy_no_mana).not_to receive(:health=)
        heal.activate
      end

      it "returns false to signal that the spell has not been activated" do
        message = heal.activate
        expect(message).to be_falsy
      end
    end
  end
end