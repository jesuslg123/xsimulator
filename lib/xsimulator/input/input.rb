# frozen_string_literal: true

require_relative '../coordinate'
require_relative 'rover_input'

# A validated and formatted representation of the program input
class Input
  attr_accessor :rovers, :area_coordinate

  def initialize(path)
    @area_coordinate = nil
    @rovers = []

    unless path
      raise StandardError, 'Missing input file path' # TODO: Custom exceptions class
    end

    read_input_file(path)
  end

  def read_input_file(file_path)
    file = open_file(file_path)

    # rubocop: disable Style/ZeroLengthPredicate
    if file.size == 0
      # rubocop: enable Style/ZeroLengthPredicate
      raise StandardError, 'Input file is empty' # TODO: Custom exceptions class
    end

    commands_lines = commands_from_input(file)

    process_commands(commands_lines)
  end

  def open_file(path)
    puts "Opening: #{path}"
    begin
      file = File.open(path, 'r')
    rescue StandardError
      raise StandardError, 'Input file not found' # TODO: Custom exceptions class
    end
    file
  end

  def commands_from_input(file)
    command_lines = []
    file.each_line do |line|
      line = line.split(' ')
      command_lines.append(line) unless line.empty?
    end
    command_lines
  end

  # TODO: Re-think
  def process_commands(commands)
    process_input_area(commands.first)

    index = 1
    while index < commands.length
      position_command = commands[index]
      index += 1
      moves_command = commands[index]

      process_input_rover(position_command, moves_command)

      index += 1
    end
  end

  def process_input_area(area_data)
    area_data = area_data.map(&:to_i) # TODO: Strings to int cast to 0

    unless valid_area?(area_data)
      raise StandardError, 'Invalid data area' # TODO: Custom exceptions class
    end

    puts "Area: #{area_data.join(',')}"

    @area_coordinate = Coordinate.new(area_data.first, area_data.last)
  end

  def process_input_rover(position_data, moves_data)
    position_data[0] = position_data.first.to_i
    position_data[1] = position_data[1].to_i

    unless valid_rover?(position_data, moves_data)
      raise StandardError, 'Invalid data rover' # TODO: Custom exceptions class
    end

    puts 'Rover data'
    puts position_data.join(',')
    puts moves_data.join(',')

    rover_input = RoverInput.new(position_data, moves_data)

    @rovers.append(rover_input)
  end

  def valid_area?(data)
    is_valid_length = data.length == 2
    is_valid_position = data.first.is_a?(Integer) && data[1].is_a?(Integer)

    result = is_valid_length && is_valid_position

    unless result
      raise StandardError, 'Invalid area provided' # TODO: Custom exceptions class
    end

    result
  end

  def valid_rover?(position_data, moves_data)
    valid_rover_positions?(position_data) && valid_rover_moves?(moves_data)
  end

  def valid_rover_positions?(position_data)
    is_valid_length = position_data.length == 3
    is_valid_position = position_data.first.is_a?(Integer) && position_data[1].is_a?(Integer)
    is_valid_orientation = position_data[2].is_a?(String) # TODO: Verify is one of the valid ["N", "S", "E", "W"]

    result = is_valid_length && is_valid_position && is_valid_orientation

    unless result
      raise StandardError, 'Invalid rover positions provided' # TODO: Custom exceptions class
    end

    result
  end

  def valid_rover_moves?(moves_data)
    result = moves_data.all? do |move|
      move.is_a?(String)
      # TODO: Verify if is a valid move ["M", "L", "R"]
    end

    unless result # TODO: Return unless is valid here?
      raise StandardError, 'Invalid rover moves provided' # TODO: Custom exceptions class
    end

    result
  end
end
