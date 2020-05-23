# frozen_string_literal: true

require 'byebug'
require_relative 'xsimulator/input/input'
require_relative 'xsimulator/map'
require_relative 'xsimulator/rover'

def main
  puts 'Initializing...'

  input = process_input
  start_exploring(input)
end

def process_input
  input_file_path = process_path_from_args
  Input.new(input_file_path)
end

def process_path_from_args
  if ARGV.empty?
    raise StandardError, 'Missing input file parameter' # TODO: Custom exceptions class
  end

  ARGV.first
end

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

main
