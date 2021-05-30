# frozen_string_literal: true

require 'spec_helper'

describe InvadersScanner::Scanner do
  subject(:scanner) { described_class.new(input: area, search_pattern: pattern) }

  let(:area) { InvadersScanner::Area.from_string(area_string) }
  let(:pattern) { InvadersScanner::Area.from_string(area_pattern_string) }

  context 'when real world example input area' do
    let(:area_string) do
      "--oo----o----oo----o---\n" \
      "-------o----------o----\n" \
      "o--oooooo--o--oooooo---\n" \
      "-oo--oo--o--oo--oo--o--\n" \
      "oo-oooooooooo-oooooooo-\n" \
      "o-ooooooo-oo-ooooooo-o-\n" \
      "oo-o----o-ooo-o----o-o-\n" \
      "--ooo-oo--o--ooo-oo--o-\n" \
      "--oo----o----oo----o---\n" \
      "-------o----------o----\n" \
      "o--oooooo--o--oooooo---\n" \
      "-oo--oo--o--oo--oo--o--\n" \
      "oo-oooooooooo-oooooooo-\n" \
      "o-ooooooo-oo-ooooooo-o-\n" \
      "oo-o----o-ooo-o----o-o-\n" \
      '--ooo-oo--o--ooo-oo--o-'
    end
    let(:area_pattern_string) do
      "--o-----o--\n" \
      "---o---o---\n" \
      "--ooooooo--\n" \
      "-oo-ooo-oo-\n" \
      "ooooooooooo\n" \
      "o-ooooooo-o\n" \
      "o-o-----o-o\n" \
      '---oo-oo---'
    end

    it 'returns 4 matches' do
      expect(scanner.scan.count).to be(4)
    end

    it 'returns matches above default similarity' do
      default_similarity = 80
      expect(scanner.scan.map(&:similarity)).to all(be > default_similarity)
    end
  end

  context 'when custom similarity' do
    subject(:scanner) { described_class.new(input: area, search_pattern: pattern, minimum_similarity: 49.9) }

    let(:area_string) do
      "-o----o-\n" \
      "--o--o--\n" \
      "---oo---\n" \
      "ooo--ooo\n" \
      "oo-oo-oo\n" \
      'o-oooo-o'
    end
    let(:area_pattern_string) do
      "-o----o-\n" \
      "--o--o--\n" \
      "---oo---\n" \
      "---oo---\n" \
      "--o--o--\n" \
      '-o----o-'
    end

    it 'returns matches' do
      expect(scanner.scan.map(&:similarity)).to all(be > 49.9)
    end
  end

  context 'when search pattern is larger then input area' do
    let(:area_string) do
      "--o-----o\n" \
      "--o-o---o\n" \
      "--o-o---o\n" \
      '--o-----o'
    end
    let(:area_pattern_string) do
      "--o-----o--\n" \
      "---o---o---\n" \
      "--ooooooo--\n" \
      "-oo-ooo-oo-\n" \
      "ooooooooooo\n" \
      "o-ooooooo-o\n" \
      "o-o-----o-o\n" \
      '---oo-oo---'
    end

    it 'raises exception' do
      expect { scanner.scan }
        .to raise_error InvadersScanner::Scanner::SearchPatternToLargeError
    end
  end
end
