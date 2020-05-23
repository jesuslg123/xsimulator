# frozen_string_literal: true

require_relative 'xsimulator/input/input'
require_relative 'xsimulator/map'
require_relative 'xsimulator/rover'

# Main class to use the rover simulator
class XSimulator
  def initialize(input_path)
    @path = input_path
  end

  def run
    puts 'Initializing...'
    input = Input.new(@path)
    start_exploring(input)
  end

  private

  def start_exploring(input)
    map = Map.new(input.area_coordinate)

    input.rovers.each do |rover_input|
      rover = Rover.new(rover_input.initial_position, rover_input.commands, map)
      success = rover.run
      print_rover_output(success, rover)
    end
  end

  def print_rover_output(success, rover)
    last_position = rover.current_position
    puts "Sequence completed: #{success}"
    puts "Position: #{last_position.coordinate.x},#{last_position.coordinate.y} #{last_position.orientation}"
  end
end
