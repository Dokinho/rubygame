RSpec.shared_examples "npc basic attributes" do

  it "has a name" do
    expect(subject).to have_attributes(name: subject.name)
  end

  it "has an x and a y position" do
    expect(subject).to have_attributes(pos_x: subject.pos_x)
    expect(subject).to have_attributes(pos_y: subject.pos_y)
  end
  
end