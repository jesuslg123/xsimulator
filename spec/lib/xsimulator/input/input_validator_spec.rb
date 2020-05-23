# frozen_string_literal: true

require_relative '../../../spec_helper'
require_relative '../../../../lib/xsimulator/input/input_validator'

RSpec.describe InputValidator do
  context 'when the area data is valid' do
    it 'has numeric string coordinates' do
      result = InputValidator.valid_area?(%w[2 1])
      expect(result).to be(true)
    end
  end

  context 'when the area data is not valid' do
    it 'has non numeric string coordinates' do
      result = InputValidator.valid_area?(%w[2 A])
      expect(result).to be(false)
    end

    it 'is missing a coordinate' do
      result = InputValidator.valid_area?(%w[2])
      expect(result).to be(false)
    end
  end

  context 'when the rover data is valid' do
    it 'has valid position' do
      result = InputValidator.valid_rover?(%w[2 3 N], %w[L M R M M R M])
      expect(result).to be(true)
    end

    it 'is oriented to North' do
      result = InputValidator.valid_rover?(%w[1 1 N], %w[L M R M M R M])
      expect(result).to be(true)
    end

    it 'is oriented to South' do
      result = InputValidator.valid_rover?(%w[1 1 S], %w[L M R M M R M])
      expect(result).to be(true)
    end

    it 'is oriented to East' do
      result = InputValidator.valid_rover?(%w[1 1 E], %w[L M R M M R M])
      expect(result).to be(true)
    end

    it 'is oriented to West' do
      result = InputValidator.valid_rover?(%w[1 1 W], %w[L M R M M R M])
      expect(result).to be(true)
    end
  end

  context 'when the rover data is not valid' do
    it 'has an invalid coordinates position' do
      result = InputValidator.valid_rover?(%w[A 3 N], %w[L M R M M R M])
      expect(result).to be(false)
    end

    it 'has an invalid orientation position' do
      result = InputValidator.valid_rover?(%w[1 3 A], %w[L M R M M R M])
      expect(result).to be(false)
    end

    it 'has an invalid move command' do
      result = InputValidator.valid_rover?(%w[1 3 N], %w[L M R A M R M])
      expect(result).to be(false)
    end

    it 'is missing position information' do
      result = InputValidator.valid_rover?(%w[1 3], %w[L M R M M R M])
      expect(result).to be(false)
    end
  end
end
