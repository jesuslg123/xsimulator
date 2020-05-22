# frozen_string_literal: true

# Representation of a polar coordinate
class Coordinate
  attr_accessor :x, :y

  def initialize(coordinate_x, coordinate_y)
    @x = coordinate_x
    @y = coordinate_y
  end
end
