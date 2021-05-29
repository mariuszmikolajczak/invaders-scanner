# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::Match do
  subject(:match) { described_class.new(chunk: area, similarity: similarity) }

  let(:start_coordinate) { InvadersScanner::Coordinate.new(3, 45) }
  let(:area) { InvadersScanner::Area.new(%w[0000 1010], start_coordinate: start_coordinate) }
  let(:similarity) { 90 }

  it 'returns coordinates' do
    expected_start_coordinate = InvadersScanner::Coordinate.new(3, 45)
    expected_end_coordinate = InvadersScanner::Coordinate.new(6, 46)
    expect(match.coordinates).to eq([expected_start_coordinate, expected_end_coordinate])
  end

  it 'returns similarity' do
    expect(match.similarity).to be(similarity)
  end
end
