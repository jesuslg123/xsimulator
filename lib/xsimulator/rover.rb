# frozen_string_literal: true

require_relative 'input/rover_input'
require_relative 'map'

# Represent the rover module which can move and explore an area
class Rover
  def initialize(position, moves, map)
    @current_position = position
    @moves = moves
    @map = map
    @compass = {
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
    puts "Position:#{@current_position.coordinate.x},#{@current_position.coordinate.y} #{@current_position.orientation}"
  end

  private

  def execute(move)
    case move.upcase
    when 'M'
      move_position
    when 'L', 'R'
      turn(move)
    else
      puts "Invalid move: #{move}. Ignoring."
    end
  end

  def move_position
    current_orientation = @current_position.orientation
    current_coordinate = @current_position.coordinate
    move_value = @compass[current_orientation.to_sym]

    next_coordinate = Coordinate.new(current_coordinate.x + move_value[0], current_coordinate.y + move_value[1])

    if @map.available?(next_coordinate)
      @map.update_rover_coordinate(current_coordinate, next_coordinate)
      @current_position.coordinate = next_coordinate
    else
      puts 'Invalid movement'
    end
  end

  def turn(direction)
    turn_value = direction == 'L' ? -1 : 1
    current_orientation_index = @compass.keys.index(@current_position.orientation.to_sym)
    next_orientation_index = (current_orientation_index + turn_value) % @compass.length
    @current_position.orientation = @compass.keys[next_orientation_index].to_s
  end
end
