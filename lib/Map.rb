require_relative "Saveable"

class Map
  include Saveable

  attr_reader :id, :name, :width, :height, :out
  attr_accessor :objects

  class OutOfBoundsError < StandardError; end

  def initialize(name = "Default Map", width = 25, height = 25)
    @name = name
    @width = width
    @height = height
    @objects = []
    @out = Array.new(height) { Array.new(width, "□") }
  end

  def render
    @out = Array.new(height) { Array.new(width, "□") }

    @objects.each do |object|
      @out[object.pos_x][object.pos_y] = object.map_marker
    end

    @out.each do |row|
      row.each { |tile| print tile + " " }
      puts
    end
  end

  def add_object(obj, x, y)
    raise OutOfBoundsError unless valid_coordinates(x, y)
    @objects << obj
    obj.pos_x = x
    obj.pos_y = y
  end

  def remove_object(obj)
    @objects.delete(obj)
  end

  def move_object(obj, x, y)
    return(move_object(obj, obj.pos_x, obj.pos_y)) unless valid_coordinates(x, y)
    obj.pos_x, obj.pos_y = x, y
  end

  # Returns the collided object if it's a NPC
  def npc_collision_at(x, y)
    npcs = @objects.select { |obj| obj.is_a?(Npc) && obj.pos_x == x && obj.pos_y == y }
    npcs.first
  end

  def valid_coordinates(x, y)
    (x >= 0) && (x < @width) && (y >= 0) && (y < @height)
  end
end