# frozen_string_literal: true

require_relative '../../../spec_helper'
require_relative '../../../../lib/xsimulator/input/input'

RSpec.describe Input do
  let(:input) { Input.new(path) }

  context 'when the source is valid' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/valid.txt" }

    it 'has valid area coordinates' do
      expect(input.area_coordinate.x).to eq(5)
      expect(input.area_coordinate.y).to eq(5)
    end

    it 'has 2 rovers input' do
      expect(input.rovers.length).to eq(2)
    end

    it 'has a first valid rover input' do
      rover_input = input.rovers.first
      expect(rover_input.initial_position.coordinate.x).to eq(1)
      expect(rover_input.initial_position.coordinate.y).to eq(2)
      expect(rover_input.initial_position.orientation).to eq('N')
      expect(rover_input.commands).to eq(%w[L M L M L M L M M])
    end

    it 'has a second valid rover input' do
      rover_input = input.rovers[1]
      expect(rover_input.initial_position.coordinate.x).to eq(3)
      expect(rover_input.initial_position.coordinate.y).to eq(3)
      expect(rover_input.initial_position.orientation).to eq('E')
      expect(rover_input.commands).to eq(%w[M M R M M R M R R M])
    end
  end

  context 'does not has file path' do
    let(:path) { nil }

    it { expect { input }.to raise_error('Missing input file path') }
  end

  context 'has an invalid file path' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/no-exists.txt" }

    it { expect { input }.to raise_error('Input file not found') }
  end

  context 'has an empty file' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/empty.txt" }

    it { expect { input }.to raise_error('Input file is empty') }
  end

  context 'is missing area info' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/invalid-missing-area-info.txt" }

    it { expect { input }.to raise_error('Invalid data area') }
  end

  context 'is missing rover info' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/invalid-missing-rover-info.txt" }

    it { expect { input }.to raise_error('Invalid data rover') }
  end

  context 'has invalid area' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/wrong-area-data.txt" }

    it { expect { input }.to raise_error('Invalid data area') }
  end

  context 'has invalid rover moves data' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/wrong-rover-data.txt" }

    it { expect { input }.to raise_error('Invalid data rover') }
  end

  context 'has invalid rover orientation data' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/wrong-rover-orientation-data.txt" }

    it { expect { input }.to raise_error('Invalid data rover') }
  end
end
