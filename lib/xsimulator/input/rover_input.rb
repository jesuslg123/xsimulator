# frozen_string_literal: true

require_relative '../position'

# A validated and formatted representation of the rover input
class RoverInput
  attr_accessor :initial_position, :commands

  def initialize(position_data, moves_data)
    @initial_position = nil
    @commands = nil

    parse_data(position_data, moves_data)
  end

  def parse_data(position_data, moves_data)
    coordinate = Coordinate.new(position_data.first, position_data[1])
    @initial_position = Position.new(coordinate, position_data.last)
    @commands = moves_data
  end
end
