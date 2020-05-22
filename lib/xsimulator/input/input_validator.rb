# frozen_string_literal: true

# Some input validation tools
class InputValidator
  VALID_MOVES = %w[M L R]
  VALID_ORIENTATIONS = %w[N S E W]

  def self.valid_area?(data)
    is_valid_length = data.length == 2
    is_valid_position = valid_coordinate_values?(data[0], data[1])

    is_valid_length && is_valid_position
  end

  def self.valid_rover?(position_data, moves_data)
    valid_rover_positions?(position_data) && valid_rover_moves?(moves_data)
  end

  def self.valid_rover_positions?(position_data)
    is_valid_length = position_data.length == 3
    is_valid_position = valid_coordinate_values?(position_data[0], position_data[1])
    is_valid_orientation = VALID_ORIENTATIONS.include?(position_data[2])

    is_valid_length && is_valid_position && is_valid_orientation
  end

  def self.valid_rover_moves?(moves_data)
    moves_data.all? do |move|
      VALID_MOVES.include?(move)
    end
  end

  def self.valid_coordinate_values?(x_value, y_value)
    number?(x_value) && number?(y_value)
  end

  def self.number?(string_value)
    num_regex = /\A[-+]?\d+\z/
    string_value.match(num_regex) != nil
  end
end
