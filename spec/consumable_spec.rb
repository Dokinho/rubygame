require_relative "../lib/Consumable"
require_relative "../lib/Item"
require_relative "../lib/Player"

RSpec.describe Consumable do

  let(:health_pot) { described_class.new("Health potion", "Heals for 20", 50,
    true, 10, "Common", "+", 20, "health")
  }

  let(:acid_pot) { described_class.new("Acid potion", "Damages for 30", 70,
    true, 10, "Common", "-", 30, "health")
  }

  let(:dummy) { instance_double(Player, "Dummy", health: 100) }

  it "has certain attributes" do
    expect(health_pot).to have_attributes(name: "Health potion")
    expect(health_pot).to have_attributes(description: "Heals for 20")
    expect(health_pot).to have_attributes(price: 50)
    expect(health_pot).to have_attributes(stackable: true)
    expect(health_pot).to have_attributes(stack_count: 10)
    expect(health_pot).to have_attributes(rarity: "Common")
    expect(health_pot).to have_attributes(type: "+")
    expect(health_pot).to have_attributes(amount: 20)
    expect(health_pot).to have_attributes(attribute: "health")
  end

  context "#affect" do

    # Should be ok?
    it "changes the target's attributes" do
      expect(dummy).to receive(:health=).with(120).exactly(1).times
      expect(dummy).to receive(:health=).with(70).exactly(1).times

      health_pot.affect(dummy)
      acid_pot.affect(dummy)
    end

  end
end