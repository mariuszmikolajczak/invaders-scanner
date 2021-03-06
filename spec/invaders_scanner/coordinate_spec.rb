# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::Coordinate do
  subject(:coordinate) { described_class.new(x, y) }

  let(:x) { 23 }
  let(:y) { 34 }

  it 'returns proper x and y coordinates' do
    expect(coordinate.x).to eql(x)
    expect(coordinate.y).to eql(y)
  end

  it 'does proper cast to array value' do
    expect(coordinate.to_a).to eql([x, y])
  end

  let(:example_cord) { described_class.new(20, 14) }

  it 'is able to add coordinates' do
    result_coordinate = coordinate + example_cord

    expect(result_coordinate.x).to eq(43)
    expect(result_coordinate.y).to eq(48)
  end

  it 'is able to subtract' do
    result_coordinate = coordinate - example_cord

    expect(result_coordinate.x).to eq(3)
    expect(result_coordinate.y).to eq(20)
  end

  let(:base_coordinate) { described_class.new(x, y) }
  let(:first_quarter_coordinate) { described_class.new(22, 33) }
  let(:first_quarter_coordinate_x_eql) { described_class.new(23, 33) }
  let(:first_quarter_coordinate_y_eql) { described_class.new(22, 34) }
  let(:second_quarter_coordinate) { described_class.new(24, 33) }
  let(:second_quarter_coordinate_y_eql) { described_class.new(24, 34) }
  let(:third_quarter_coordinate) { described_class.new(22, 35) }
  let(:third_quarter_coordinate_x_eql) { described_class.new(23, 35) }
  let(:fourth_quarter_coordinate) { described_class.new(24, 35) }

  it 'is be able to tell that is greater' do
    expect(base_coordinate).to be > first_quarter_coordinate
    expect(base_coordinate).to be > first_quarter_coordinate_x_eql
    expect(base_coordinate).to be > first_quarter_coordinate_y_eql
  end

  it 'is be able to tell that is smaller' do
    expect(base_coordinate).to be < second_quarter_coordinate
    expect(base_coordinate).to be < second_quarter_coordinate_y_eql
    expect(base_coordinate).to be < third_quarter_coordinate
    expect(base_coordinate).to be < third_quarter_coordinate_x_eql
    expect(base_coordinate).to be < fourth_quarter_coordinate
  end

  let(:another_equal_coordinate) { described_class.new(x, y) }

  it 'is be able to tell that is equal' do
    expect(coordinate).to eq(another_equal_coordinate)
  end

  it 'raises error when until coordination is smaller' do
    expect {
      coordinate.each_until(described_class.new(0, 0))
    }.to raise_error InvadersScanner::Coordinate::UnexpectedUntilCoordinate
  end

  it 'iterates to given point' do
    result = []
    coordinate.each_until(described_class.new(25, 35)) do |cord|
      result.push(cord)
    end

    expected_arry = [
      described_class.new(23, 34),
      described_class.new(24, 34),
      described_class.new(25, 34),
      described_class.new(23, 35),
      described_class.new(24, 35),
      described_class.new(25, 35)
    ]

    expect(result).to eq(expected_arry)
  end
end
