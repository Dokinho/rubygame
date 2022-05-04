require_relative "../lib/Map"
require_relative "../lib/Npc"

RSpec.describe Map do
  let(:map) { Map.new("Mapa", 30, 20) }
  let(:map_no_args) { Map.new }

  let(:npc) { instance_double(Npc, "A guy", :pos_x= => "ok", :pos_y= => "ok") }

  context "without arguments" do

    it "has a default name" do
      expect(map_no_args).to have_attributes(name: "Default Map")
    end

    it "has a default height and width" do
      expect(map_no_args).to have_attributes(width: 25)
      expect(map_no_args).to have_attributes(height: 25)
    end

    it "has objects stored in an array" do
      expect(map_no_args).to have_attributes(objects: [])
    end

    it "has a 2D array of its tiles named 'out'" do
      expect(map_no_args).to have_attributes(out: Array.new(25) { Array.new(25, "□") })
    end

  end

  context "with arguments" do

    it "has a specified name" do
        expect(map).to have_attributes(name: "Mapa")
    end

    it "has a specified height and width" do
        expect(map).to have_attributes(width: 30)
        expect(map).to have_attributes(height: 20)
    end

    it "has objects stored in an array" do
        expect(map).to have_attributes(objects: [])
    end

    it "has a 2D array of its tiles named 'out'" do
      expect(map).to have_attributes(out: Array.new(20) { Array.new(30, "□") })
    end

  end

  # IDK yet
  context "#render method" do
    it "loops through 'objects' and puts the corresponding character on screen" do
    end
  end

  context "#add_object method" do

    it "adds an object to the specified coordinates" do
      map.add_object(npc, 10, 10)
      expect(map.objects).to include(npc)
    end

    it "added object should have the specified coordinates in itself" do
      expect(npc).to receive(:pos_x=).with(15)
      expect(npc).to receive(:pos_y=).with(15)
      map.add_object(npc, 15, 15)
    end

  end 

  context "#remove_object method" do

    it "removes the specified object from the objects array" do
      map.add_object(npc, 10, 10)
      expect(map.objects).to include(npc)

      map.remove_object(npc)
      expect(map.objects).not_to include(npc)
    end

  end

  context "#move_object method" do

    before do
      allow(npc).to receive(:pos_x).and_return(0)
      allow(npc).to receive(:pos_y).and_return(0)
      map.add_object(npc, 0, 0)
    end

    it "sets object coordinates" do
      expect(npc).to receive(:pos_x=).with(15)
      expect(npc).to receive(:pos_y=).with(15)

      map.move_object(npc, 15, 15)
    end

    it "returns the starting coordinates if they are out of the map" do
      expect(npc).to receive(:pos_x=).with(0)
      expect(npc).to receive(:pos_y=).with(0)

      map.move_object(npc, -1, -1)
    end

  end

  context "#npc_collision_at method" do

    before do
      allow(npc).to receive(:pos_x).and_return(0)
      allow(npc).to receive(:pos_y).and_return(0)
      allow(npc).to receive(:is_a?).and_return(Npc)
      map.add_object(npc, 0, 0)
    end

    it "returns a npc object if it is on the specified coordinates or nil if not" do
      expect(map.npc_collision_at(0, 0)).to eq(npc)
      expect(map.npc_collision_at(5, 6)).to be_nil
    end
  end

  context "#valid_coordinates method" do
    it "checks whether given map coordinates are within the map" do
      expect(map.valid_coordinates(50, 50)).to be_falsy
      expect(map.valid_coordinates(5, 6)).to be_truthy
    end
  end

end