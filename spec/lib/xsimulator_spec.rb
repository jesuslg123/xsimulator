# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/xsimulator/input/input'
require_relative '../../lib/xsimulator'

RSpec.describe XSimulator do
  context 'when input is valid' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/valid.txt" }
    let(:expected_cli_output) do
      "Initializing...\nSequence completed: true\nPosition: 1,3 N\nSequence completed: true\nPosition: 5,1 E\n"
    end

    it 'has the next output' do
      expect { XSimulator.new(path).run }.to output(expected_cli_output).to_stdout
    end
  end

  context 'when input is not valid' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/invalid.txt" }

    it 'has the next output' do
      expect { XSimulator.new(path).run }.to raise_error(Input::RoverDataError)
    end
  end
end
