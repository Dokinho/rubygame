class Map
  attr_reader :id, :name, :width, :height, :out
  attr_accessor :objects

  class OutOfBoundsError < StandardError; end

  def initialize(name = "Default Map", width = 25, height = 25)
    @id = self.object_id
    @name = name
    @width = width
    @height = height
    @objects = Array.new(height) { Array.new(width, "tile") }
  end

  def render
    @objects.each do |row|
      puts
      row.each { |tile| tile == "tile" ? print("□ ") : print("#{tile.map_marker} ") }
    end
  end

  def add_object(obj, x, y)
    raise OutOfBoundsError unless valid_coordinates(x, y)
    @objects[x][y] = obj
    obj.pos_x = x
    obj.pos_y = y
  end

  def remove_object(obj)
    @objects[obj.pos_x][obj.pos_y] = "tile"
  end

  def move_object(obj, x, y)
    return(move_object(obj, obj.pos_x, obj.pos_y)) unless valid_coordinates(x, y)
    remove_object(obj)
    add_object(obj, x, y)
  end

  def check_collision(x, y)

  end

  def valid_coordinates(x, y)
    (x >= 0) && (x <= @width) && (y >= 0) && (y <= @height)
  end
end