# frozen_string_literal: true

# Representation of a polar coordinate
class Coordinate
  attr_accessor :x, :y

  def initialize(coordinate_x, coordinate_y)
    @x = coordinate_x
    @y = coordinate_y
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def +(other)
    Coordinate.new(@x + other.x, @y + other.y)
  end
end
