require_relative "../lib/Weapon"
require_relative "../lib/Item"

RSpec.describe Weapon do
  subject(:noz) { described_class.new("Noz", "Jako ubada", 200, false, 1,
    "Common", 15, 1) }

  it { is_expected.to have_attributes(name: "Noz") }
  it { is_expected.to have_attributes(description: "Jako ubada") }
  it { is_expected.to have_attributes(price: 200) }
  it { is_expected.to have_attributes(stackable: false) }
  it { is_expected.to have_attributes(stack_count: 1) }
  it { is_expected.to have_attributes(rarity: "Common") }
  it { is_expected.to have_attributes(damage: 15) }
  it { is_expected.to have_attributes(req_lvl: 1) }
end