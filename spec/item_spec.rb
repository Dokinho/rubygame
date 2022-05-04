require_relative "../lib/Item"
require_relative "../lib/Weapon"
require_relative "../lib/Consumable"

RSpec.describe Item do
  subject { described_class.new("Test Item", "This is a test item", 100,
    false, 1, "Rare") }

    it { is_expected.to have_attributes(name: "Test Item") }
    it { is_expected.to have_attributes(description: "This is a test item") }
    it { is_expected.to have_attributes(price: 100) }
    it { is_expected.to have_attributes(stackable: false) }
    it { is_expected.to have_attributes(stack_count: 1) }
    it { is_expected.to have_attributes(rarity: "Rare") }

end