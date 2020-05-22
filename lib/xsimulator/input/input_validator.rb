# frozen_string_literal: true

# Some input validation tools
class InputValidator
  def self.valid_area?(data)
    is_valid_length = data.length == 2
    is_valid_position = data.first.is_a?(Integer) && data[1].is_a?(Integer)

    result = is_valid_length && is_valid_position

    unless result
      raise StandardError, 'Invalid area provided' # TODO: Custom exceptions class
    end

    result
  end

  def self.valid_rover?(position_data, moves_data)
    valid_rover_positions?(position_data) && valid_rover_moves?(moves_data)
  end

  def self.valid_rover_positions?(position_data)
    is_valid_length = position_data.length == 3
    is_valid_position = position_data.first.is_a?(Integer) && position_data[1].is_a?(Integer)
    is_valid_orientation = position_data[2].is_a?(String) # TODO: Verify is one of the valid ["N", "S", "E", "W"]

    result = is_valid_length && is_valid_position && is_valid_orientation

    unless result
      raise StandardError, 'Invalid rover positions provided' # TODO: Custom exceptions class
    end

    result
  end

  def self.valid_rover_moves?(moves_data)
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
