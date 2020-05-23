# frozen_string_literal: true

require_relative 'input/rover_input'
require_relative 'map'

# Represent the rover module which can move and explore an area
class Rover
  class InvalidActionError < StandardError; end
  class InvalidMoveError < StandardError; end

  attr_accessor :current_position

  def initialize(position, moves, map)
    @current_position = position
    @moves = moves
    @map = map
    @compass = { # TODO: Change for coordinates
      W: [-1, 0],
      N: [0, 1],
      E: [1, 0],
      S: [0, -1]
    }
  end

  def run
    @moves.each do |move|
      execute(move)
    end
    true
  rescue StandardError
    false
  end

  private

  def execute(action)
    case action.upcase
    when 'M'
      move_position
    when 'L', 'R'
      turn(action)
    else
      raise InvalidActionError, "Invalid action: #{action}"
    end
  end

  def move_position
    next_coordinate = calculate_next_coordinate

    raise InvalidMoveError, 'Invalid rover move' unless @map.available?(next_coordinate)

    @map.update_rover_coordinate(current_coordinate, next_coordinate)
    @current_position = Position.new(next_coordinate, current_orientation)
  end

  def turn(direction)
    turn_value = direction == 'L' ? -1 : 1
    current_orientation_index = @compass.keys.index(current_orientation.to_sym)
    next_orientation_index = (current_orientation_index + turn_value) % @compass.length
    @current_position.orientation = @compass.keys[next_orientation_index].to_s
  end

  def calculate_next_coordinate
    move_value = @compass[current_orientation.to_sym]
    Coordinate.new(current_coordinate.x + move_value[0], current_coordinate.y + move_value[1])
  end

  def current_orientation
    @current_position.orientation
  end

  def current_coordinate
    @current_position.coordinate
  end
end
