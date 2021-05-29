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
    %w[00100000100
     00010001000
     00111111100
     01101110110
     11111111111
     10111111101
     10100000101
     00011011000]
  end

  it 'should convert from ascii string to bit string array' do
    expect(converter.call).to eql(expected_output)
  end

  context 'unknown char found' do
    let(:input) { '---ooii---' }

    it 'should raise exception' do
      expect { converter.call }.to raise_error InvadersScanner::StringToBinaryConverter::UnknownCharError
    end
  end

  context 'custom char map' do
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

    subject(:custom_converter) { described_class.new(string: input, char_map: char_map) }

    it 'should convert' do
      expect(custom_converter.call).to eql(expected_output)
    end

    context 'unexpected binary value provided' do
      let(:char_map) do
        {
          'q' => '2',
          'w' => '0'
        }
      end

      it 'should raise exception' do
        expect { custom_converter.call }.to raise_error InvadersScanner::StringToBinaryConverter::UnexpectedBinaryValue
      end
    end
  end
end
