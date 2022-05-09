require_relative "../lib/Ability"
require_relative "../lib/Enemy"

RSpec.describe Ability do
  subject { Ability.new("Attack", "Basic attack", "-", "10", "health") }

  let(:bad_guy) { instance_double(Enemy, "Bad Guy", health: 100) }

  context "attributes" do
    it { is_expected.to have_attributes(name: :Attack) }
    it { is_expected.to have_attributes(description: "Basic attack") }
    it { is_expected.to have_attributes(type: "-") }
    it { is_expected.to have_attributes(amount: "10") }
    it { is_expected.to have_attributes(attribute: "health") }
    it { is_expected.to have_attributes(owner: nil) }
  end

  context "#activate method" do
    it "changes the target's attributes" do
      expect(bad_guy).to receive(:health=).with(90).exactly(1).times
      subject.activate(bad_guy)
    end
  end
end