# frozen_string_literal: true

require_relative 'coordinate'

# Represent an item position in a plane with orientation and coordinates
class Position
  attr_accessor :coordinate, :orientation

  def initialize(coordinate, orientation)
    @coordinate = coordinate
    @orientation = orientation
  end
end
