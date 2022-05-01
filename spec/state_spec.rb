require_relative "../lib/State"

RSpec.describe State do

  it "should have a default main menu loop" do
    expect(subject).to respond_to(:menu)
  end

  it "should have a combat loop" do
    expect(subject).to respond_to(:combat)
  end

  it "should have a shop loop" do
    expect(subject).to respond_to(:shop)
  end
end