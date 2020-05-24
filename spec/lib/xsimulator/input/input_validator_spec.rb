# frozen_string_literal: true

require_relative '../../../spec_helper'
require_relative '../../../../lib/xsimulator/input/input_validator'

RSpec.describe InputValidator do
  describe '.valid_area?' do
    subject { InputValidator.valid_area?(area) }

    context 'when the area data is valid' do
      let(:area) { %w[2 1] }

      it { is_expected.to be(true) }
    end

    context 'when the area data are not numbers' do
      let(:area) { %w[2 A] }

      it { is_expected.to be(false) }
    end

    context 'when the area data is incomplete' do
      let(:area) { %w[2] }

      it { is_expected.to be(false) }
    end
  end

  describe '.valid_rover?' do
    subject { InputValidator.valid_rover?(position, moves) }

    let(:moves) { %w[L M R M M R M] }
    let(:position) { %w[2 3 N] }

    context 'when the rover data is valid' do
      it { is_expected.to be(true) }
    end

    context 'when the rover is heading North' do
      let(:position) { %w[1 1 N] }

      it { is_expected.to be(true) }
    end

    context 'when the rover is heading South' do
      let(:position) { %w[1 1 S] }

      it { is_expected.to be(true) }
    end

    context 'when the rover is heading East' do
      let(:position) { %w[1 1 E] }

      it { is_expected.to be(true) }
    end

    context 'when the rover is heading West' do
      let(:position) { %w[1 1 W] }

      it { is_expected.to be(true) }
    end

    context 'when coordinates are invalids' do
      let(:position) { %w[A 3 N] }

      it { is_expected.to be(false) }
    end

    context 'when orientation is invalid' do
      let(:position) { %w[1 3 A] }

      it { is_expected.to be(false) }
    end

    context 'when position is incomplete' do
      let(:position) { %w[1 3] }

      it { is_expected.to be(false) }
    end

    context 'when move contains an invalid action' do
      let(:moves) { %w[L M R A M R M] }

      it { is_expected.to be(false) }
    end
  end
end
