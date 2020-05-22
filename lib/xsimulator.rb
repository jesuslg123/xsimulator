# frozen_string_literal: true

require 'byebug'
require_relative 'xsimulator/input/input'
require_relative 'xsimulator/rover'

def main
  puts 'Initializing....'

  input_file_path = process_path_from_args
  input = Input.new(input_file_path)
  input.rovers.each do |rover_input|
    rover = Rover.new(rover_input.initial_position, rover_input.commands)
    rover.run
  end
end

def process_path_from_args
  if ARGV.empty?
    raise StandardError, 'Missing input file parameter' # TODO: Custom exceptions class
  end

  ARGV.first
end

main
