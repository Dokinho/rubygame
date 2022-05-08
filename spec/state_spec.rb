require_relative "../lib/State"

RSpec.describe State do
    it {is_expected.to respond_to(:menu)}
    it {is_expected.to respond_to(:map)}
    it {is_expected.to respond_to(:walk)}
    it {is_expected.to respond_to(:interaction)}
    it {is_expected.to respond_to(:character)}
    it {is_expected.to respond_to(:inventory)}
    it {is_expected.to respond_to(:use)}
    it {is_expected.to respond_to(:equip)}
    it {is_expected.to respond_to(:quests)}
    it {is_expected.to respond_to(:quit)}
end