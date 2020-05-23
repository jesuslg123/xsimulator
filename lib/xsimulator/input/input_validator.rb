# frozen_string_literal: true

# Some input validation tools
class InputValidator
  VALID_MOVES = %w[M L R].freeze
  VALID_ORIENTATIONS = %w[N S E W].freeze

  def self.valid_area?(data)
    return false if !data || data.length != 2

    valid_coordinate_values?(data[0], data[1])
  end

  def self.valid_rover?(position_data, moves_data)
    position_data && moves_data &&
      valid_rover_position?(position_data) && valid_rover_moves?(moves_data)
  end

  def self.valid_rover_position?(data)
    return false if !data || data.length != 3

    is_valid_position = valid_coordinate_values?(data[0], data[1])
    is_valid_orientation = VALID_ORIENTATIONS.include?(data[2])

    is_valid_position && is_valid_orientation
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
    return false if string_value.nil?

    num_regex = /\A[-+]?\d+\z/
    string_value.match(num_regex) != nil
  end

  private_class_method :valid_rover_position?, :valid_rover_moves?, :valid_coordinate_values?, :number?
end
