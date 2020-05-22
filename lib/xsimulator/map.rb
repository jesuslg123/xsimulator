# frozen_string_literal: true

require_relative 'coordinate'

# Map entity represent an area with information about its limits and rovers positions
class Map
  attr_accessor :bottom_left_coordinate, :top_right_coordinate, :rovers_coordinate

  def initialize(top_right, bottom_left = Coordinate.new(0, 0))
    @bottom_left_coordinate = bottom_left
    @top_right_coordinate = top_right
  end

  def available?(coordinate)
    valid_x = coordinate.x >= @bottom_left_coordinate.x && coordinate.x <= @top_right_coordinate.x
    valid_y = coordinate.y >= @bottom_left_coordinate.y && coordinate.y <= @top_right_coordinate.y

    valid_x && valid_y
  end
end
