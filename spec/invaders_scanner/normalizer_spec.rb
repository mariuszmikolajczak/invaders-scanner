# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::Normalizer do
  context 'when default options' do
    subject(:normalizer) { described_class.new(string: string) }

    let(:string) { '----oooo----O' }
    let(:expected_string) { '----oooo----o' }

    it 'replace not recognized' do
      expect(normalizer.call).to eq(expected_string)
    end

    context 'when string normalized' do
      let(:string) { '----oooo----o' }

      it 'returns same string' do
        expect(normalizer.call).to eq(string)
      end
    end
  end

  context 'when custom options' do
    subject(:normalizer) do
      described_class.new(string: string, allowed_chars: allowed_chars, change_others_to: to_char)
    end

    let(:string) { 'abcdefgh1111001001' }
    let(:expected_string) { '000000001111001001' }
    let(:allowed_chars) { %w[0 1] }
    let(:to_char) { '0' }

    it 'normalizes string' do
      expect(normalizer.call).to eq(expected_string)
    end

    context 'when to char is different then allowed chars' do
      let(:allowed_chars) { %w[a b c] }
      let(:to_char) { 'd' }

      it 'raises exception' do
        expect { normalizer.call }
          .to raise_error InvadersScanner::Normalizer::AllowedCharsMismatchError
      end
    end
  end
end
