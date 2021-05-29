# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::Area do
  subject(:area) { described_class.from_string(input_string) }

  describe 'from_string' do
    let(:input_string) do
      "o--\n" \
      "-o-\n" \
      '---'
    end

    it 'does create Area object from given string' do
      expect(area).to be_an_is_a(described_class)
    end
  end

  describe 'instance' do
    let(:input_string) do
      "----\n" \
      "-oo-\n" \
      "-oo-\n" \
      '----'
    end

    let(:expected_chunks) do
      [
        %w[00 01], %w[00 11], %w[00 10], %w[01 01], %w[11 11], %w[10 10], %w[01 00], %w[11 00], %w[10 00]
      ]
    end

    it 'iterates through area chunks on given coordinate size' do
      result = []
      area.each_chunk(InvadersScanner::Coordinate.new(1, 1)) do |chunk|
        result.push(chunk.array_value)
      end

      expect(result).to eq(expected_chunks)
    end

    it 'does calculate max coordinate' do
      expect(area.max_coordinate).to eq(InvadersScanner::Coordinate.new(3, 3))
    end

    it 'raises out ouf area exception after wrong coordinate passed' do
      coordinate1 = InvadersScanner::Coordinate.new(1, 1)
      coordinate2 = InvadersScanner::Coordinate.new(4, 4)
      expect { area.chunk(coordinate1, coordinate2) }
        .to raise_error InvadersScanner::Area::OutOfAreaException
    end
  end
end
