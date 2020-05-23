# frozen_string_literal: true

require_relative '../coordinate'
require_relative 'input_validator'
require_relative 'rover_input'

# A validated and formatted representation of the program input
class Input
  attr_accessor :rovers, :area_coordinate

  class MissingPathError < StandardError; end
  class FileNotFoundError < StandardError; end
  class EmptyFileError < StandardError; end
  class AreaDataError < StandardError; end
  class RoverDataError < StandardError; end

  def initialize(path)
    @area_coordinate = nil
    @rovers = []

    raise MissingPathError, 'Missing input file path' unless path

    read_input_file(path)
  end

  def read_input_file(file_path)
    commands_lines = commands_from_input(file_path)

    raise EmptyFileError, 'Input file is empty' if commands_lines.empty?

    process_commands(commands_lines)
  end

  def commands_from_input(path)
    File.readlines(path).map(&:split).reject(&:empty?)
  rescue Errno::ENOENT
    raise FileNotFoundError, 'Input file not found'
  end

  # TODO: Re-think
  def process_commands(commands)
    process_input_area(commands.first)

    index = 1
    while index < commands.length
      position = commands[index]
      index += 1
      actions = commands[index]

      process_input_rover(position, actions)

      index += 1
    end
  end

  def process_input_area(area_data)
    raise AreaDataError, 'Invalid data area' unless InputValidator.valid_area?(area_data)

    area_data = area_data.map(&:to_i)

    @area_coordinate = Coordinate.new(area_data.first, area_data.last)
  end

  def process_input_rover(position_data, moves_data)
    raise RoverDataError, 'Invalid data rover' unless InputValidator.valid_rover?(position_data, moves_data)

    position_data[0] = position_data[0].to_i
    position_data[1] = position_data[1].to_i

    rover_input = RoverInput.new(position_data, moves_data)

    @rovers.append(rover_input)
  end
end
