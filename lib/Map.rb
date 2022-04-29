class Map
  attr_reader :id, :name, :width, :height, :out
  attr_accessor :objects

  class OutOfBoundsError < StandardError; end

  def initialize(name = "Default Map", width = 25, height = 25)
    @id = self.object_id
    @name = name
    @width = width
    @height = height
    @objects = Array.new(width) { Array.new(height, "tile") }
    @out = Array.new(width, Array.new(height, 0))
  end

  def render
    @out.each do |row|
      puts row
    end
  end

  def add_object(obj, x, y)
    raise OutOfBoundsError if (x < 0) || (x > @width) || (y < 0) || (y > @height)
    @objects[x][y] = obj
    obj.pos_x = x
    obj.pos_y = y
  end

  def remove_object(obj)
    @objects[obj.pos_x][obj.pos_y] = "tile"
  end

  def check_collision

  end
end