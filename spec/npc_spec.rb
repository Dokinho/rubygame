require_relative "../lib/Npc"
require_relative "../image_art/Image"
require_relative "npc_shared_examples"

RSpec.describe Npc do
  include_examples "npc basic attributes"

  it "has a default map marker" do
    expect(subject).to have_attributes(map_marker: "*")
  end

  it "has an image" do
    expect(subject).to have_attributes(image: Image::NPC_DEFAULT)
  end

end