require_relative "../lib/Map"
require_relative "../lib/Npc"

RSpec.describe Map do
  let(:map) { Map.new("Mapa", 30, 20) }
  let(:map_no_args) { Map.new }

  let(:npc) { instance_double(Npc, "A guy", :pos_x= => "ok", :pos_y= => "ok") }

  context "without arguments" do

    it "has an id equal to its object_id" do
      expect(map_no_args).to have_attributes(id: map_no_args.object_id)
    end

    it "has a default name" do
      expect(map_no_args).to have_attributes(name: "Default Map")
    end

    it "has a default height and width" do
      expect(map_no_args).to have_attributes(width: 25)
      expect(map_no_args).to have_attributes(height: 25)
    end

    it "has object storage in a 2D array" do
      expect(map_no_args).to have_attributes(objects: Array.new(25, Array.new(25, "tile")))
    end

  end

  context "with arguments" do
      
    it "has an id equal to its object_id" do
        expect(map).to have_attributes(id: map.object_id)
    end

    it "has a specified name" do
        expect(map).to have_attributes(name: "Mapa")
    end

    it "has a specified height and width" do
        expect(map).to have_attributes(width: 30)
        expect(map).to have_attributes(height: 20)
    end

    it "has object storage in a 2D array" do
        expect(map).to have_attributes(objects: Array.new(20, Array.new(30, "tile")))
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
      expect(map.objects[10][10]).to eq(npc)
    end

    it "added object should have the specified coordinates in itself" do
      expect(npc).to receive(:pos_x=).with(15)
      expect(npc).to receive(:pos_y=).with(15)
      map.add_object(npc, 15, 15)
    end

  end 

  context "#remove_object method" do

    it "removes the specified object from the map" do
      allow(npc).to receive_messages(pos_x: 10, pos_y: 10)
      map.add_object(npc, 10, 10)
      expect(map.objects[10][10]).to eq(npc)

      map.remove_object(npc)
      expect(map.objects[10][10]).not_to eq(npc)
    end

  end

  context "#valid_coordinates method" do
    it "checks whether given map coordinates are within the map" do
      expect(map.valid_coordinates(50, 50)).to be_falsy
      expect(map.valid_coordinates(5, 6)).to be_truthy
    end
  end

end