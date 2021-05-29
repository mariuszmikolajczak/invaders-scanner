require 'spec_helper'

describe InvadersScanner::Comparator2d do

  subject(:comparator) { described_class }

  context 'when arrays are the same' do
    let(:arrays) do
      [
        %w[00000000],
        %w[11111111],
        %w[01010101],
        %w[10101010],
        %w[11111111, 00000000],
        %w[00000000, 11111111],
        %w[10101010, 01010101],
        %w[10101010 01010101 11100111 00011000]
      ]
    end

    it 'should return 100' do
      arrays.each do |array|
        expect(comparator.new(array, array).call).to eq(100)
      end
    end
  end

  context 'when arrays are totally different' do
    let(:arrays) do
      {
        %w[00000000] => %w[11111111],
        %w[11111111] => %w[00000000],
        %w[01010101] => %w[10101010],
        %w[10101010 01010101 11100111 00011000] => %w[01010101 10101010 00011000 11100111]
      }
    end

    it 'should return 0' do
      arrays.each do |first_arry, second_arry|
        expect(comparator.new(first_arry, second_arry).call).to eq(0)
      end
    end
  end

  context 'when arrays are similar' do
    let(:arrays) do
      [
        [75, %w[00111111], %w[11111111]],
        [75, %w[00001111 11111111], %w[11111111 11111111]],
        [50, %w[00001111], %w[00000000]],
        [50, %w[11111111 00000000], %w[00000000 00000000]],
        [25, %w[00001111 11111111], %w[00000000 00000000]]
      ]
    end

    it 'should return similarity' do
      arrays.each do |expected_similarity, first_arry, second_arry|
        expect(comparator.new(first_arry, second_arry).call).to eq(expected_similarity)
      end
    end
  end
end
