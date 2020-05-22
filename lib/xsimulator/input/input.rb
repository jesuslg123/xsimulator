# frozen_string_literal: true

require_relative '../coordinate'
require_relative 'input_validator'
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
    unless InputValidator.valid_area?(area_data)
      raise StandardError, 'Invalid data area' # TODO: Custom exceptions class
    end

    area_data = area_data.map(&:to_i)

    puts "Area: #{area_data.join(',')}"

    @area_coordinate = Coordinate.new(area_data.first, area_data.last)
  end

  def process_input_rover(position_data, moves_data)
    unless InputValidator.valid_rover?(position_data, moves_data)
      raise StandardError, 'Invalid data rover' # TODO: Custom exceptions class
    end

    position_data[0] = position_data[0].to_i
    position_data[1] = position_data[1].to_i

    puts 'Rover data'
    puts position_data.join(',')
    puts moves_data.join(',')

    rover_input = RoverInput.new(position_data, moves_data)

    @rovers.append(rover_input)
  end
end
