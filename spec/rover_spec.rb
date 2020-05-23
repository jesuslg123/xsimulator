# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/xsimulator/rover'

RSpec.describe Rover do
  let(:rover) { Rover.new(position, moves, map) }
  let(:position) { Position.new(Coordinate.new(1, 2), 'N') }
  let(:moves) { %w[L R M M L M L M] }
  let(:map) { Map.new(Coordinate.new(5, 5)) }
  let(:last_position) { rover.current_position }

  let!(:rover_run) { rover.run }

  context 'when the rover data is valid' do
    it 'has movement in area' do
      expect(rover_run).to be(true)
      expect(last_position.orientation).to eq('S')
      expect(last_position.coordinate.x).to eq(0)
      expect(last_position.coordinate.y).to eq(3)
    end
  end

  context 'when the rover commands leave the area' do
    let(:map) { Map.new(Coordinate.new(3, 3)) }

    it 'last position is last valid one' do
      expect(rover_run).to be(false)
      expect(last_position.orientation).to eq('N')
      expect(last_position.coordinate.x).to eq(1)
      expect(last_position.coordinate.y).to eq(3)
    end
  end

  context 'when there are two rovers without collision' do
    let(:rover_two_moves) { %w[L L M L M M] }
    let(:rover_two) { Rover.new(position, rover_two_moves, map) }
    let(:rover_two_last_position) { rover_two.current_position }

    let!(:rover_two_run) { rover_two.run }

    it 'both rovers complete movements' do
      expect(rover_run).to be(true)
      expect(rover_two_run).to be(true)
    end
  end

  context 'when there are two rovers that collide' do
    let(:rover_two_moves) { %w[L R M M L M L M L M M] }
    let(:rover_two) { Rover.new(position, rover_two_moves, map) }
    let(:rover_two_last_position) { rover_two.current_position }

    let!(:rover_two_run) { rover_two.run }

    it 'last position is last before collision' do
      expect(rover_run).to be(true)
      expect(rover_two_run).to be(false)
      expect(rover_two_last_position.orientation).to eq('S')
      expect(rover_two_last_position.coordinate.x).to eq(0)
      expect(rover_two_last_position.coordinate.y).to eq(4)
    end
  end
end
