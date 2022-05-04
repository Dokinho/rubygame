require_relative "../lib/Npc"
require_relative "npc_shared_examples"

RSpec.describe Npc do
  include_examples "npc basic attributes"

  it "has a default map marker" do
    expect(subject).to have_attributes(map_marker: "*")
  end
end