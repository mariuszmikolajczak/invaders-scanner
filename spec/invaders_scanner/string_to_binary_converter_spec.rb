# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::StringToBinaryConverter do
  subject(:converter) { described_class.new(string: input) }

  let(:input) do
    "--o-----o--\n" \
    "---o---o---\n" \
    "--ooooooo--\n" \
    "-oo-ooo-oo-\n" \
    "ooooooooooo\n" \
    "o-ooooooo-o\n" \
    "o-o-----o-o\n" \
    "---oo-oo---\n"
  end
  let(:expected_output) do
    %w[
      00100000100
      00010001000
      00111111100
      01101110110
      11111111111
      10111111101
      10100000101
      00011011000
    ]
  end

  it 'converts from ascii string to bit string array' do
    expect(converter.call).to eql(expected_output)
  end

  context 'when unknown char found' do
    let(:input) { '---ooii---' }

    it 'raises exception' do
      expect { converter.call }
        .to raise_error InvadersScanner::StringToBinaryConverter::UnknownCharError
    end
  end

  context 'when custom char map' do
    subject(:custom_converter) { described_class.new(string: input, char_map: char_map) }

    let(:input) do
      "qwwwqqqww\n" \
      "wwwqqwqwq\n"
    end
    let(:expected_output) do
      %w[100011100 000110101]
    end
    let(:char_map) do
      {
        'q' => InvadersScanner::StringToBinaryConverter::POSITIVE_VALUE,
        'w' => InvadersScanner::StringToBinaryConverter::NEGATIVE_VALUE
      }
    end

    it 'converts string' do
      expect(custom_converter.call).to eql(expected_output)
    end

    context 'when unexpected binary value provided' do
      let(:char_map) { { 'q' => '2', 'w' => '0' } }

      it 'raises exception' do
        expect { custom_converter.call }
          .to raise_error InvadersScanner::StringToBinaryConverter::UnexpectedBinaryValue
      end
    end
  end
end
