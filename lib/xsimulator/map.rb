# frozen_string_literal: true

require_relative 'coordinate'

# Map entity represent an area with information about its limits and rovers positions
class Map
  attr_accessor :bottom_left_coordinate, :top_right_coordinate, :rovers_coordinate

  def initialize(top_right, bottom_left = Coordinate.new(0, 0))
    @bottom_left_coordinate = bottom_left
    @top_right_coordinate = top_right
    @rovers_coordinate = []
  end

  def available?(coordinate)
    valid_x = coordinate.x >= @bottom_left_coordinate.x && coordinate.x <= @top_right_coordinate.x
    valid_y = coordinate.y >= @bottom_left_coordinate.y && coordinate.y <= @top_right_coordinate.y
    in_use = @rovers_coordinate.include?(coordinate)

    valid_x && valid_y && !in_use
  end

  def update_rover_coordinate(old_coordinate, new_coordinate)
    @rovers_coordinate.delete(old_coordinate)
    @rovers_coordinate.append(new_coordinate)
  end
end
