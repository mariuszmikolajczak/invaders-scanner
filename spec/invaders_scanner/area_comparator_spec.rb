# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::AreaComparator do
  subject(:area_comparator) { described_class.new(area1, area2) }

  let(:input_string) do
    "----\n" \
    "-oo-\n" \
    "-oo-\n" \
    '----'
  end
  let(:area1) { InvadersScanner::Area.from_string(input_string) }
  let(:area2) { InvadersScanner::Area.from_string(input_string) }

  context 'when the same areas' do
    it 'returns 100% match' do
      expect(area_comparator.call).to eq(100)
    end
  end

  context 'when different areas' do
    let(:input_string1) do
      "o--o\n" \
      "-oo-\n" \
      "-oo-\n" \
      'o--o'
    end
    let(:input_string2) do
      "o--o\n" \
      "-o--\n" \
      "--o-\n" \
      'o--o'
    end
    let(:area1) { InvadersScanner::Area.from_string(input_string1) }
    let(:area2) { InvadersScanner::Area.from_string(input_string2) }

    it 'returns 87.5% match' do
      expect(area_comparator.call).to eq(87.5)
    end
  end

  context 'when custom comparator provided' do
    subject(:area_comparator) { described_class.new(area1, area2, comparator: comparator_class) }

    let(:comparator_return_value) { 'anything'                }
    let(:comparator_class)        { double(:comparator_class) }

    it 'returns custom comparator value' do
      allow(comparator_class).to receive(:new).and_return(double(:comparator, call: comparator_return_value))

      expect(area_comparator.call).to eq(comparator_return_value)
    end
  end
end
