# frozen_string_literal: true

module InvadersScanner
  class Scanner
    def initialize(input:, search_pattern:, minimum_similarity: 80, comparator: AreaComparator)
      @input_area = input
      @search_pattern_area = search_pattern
      @minimum_similarity = minimum_similarity
      @comparator = comparator
    end

    def scan
      matches = []
      input_area.each_chunk(search_pattern_area.max_coordinate) do |chunk|
        similarity = comparator.new(chunk, search_pattern_area).call
        matches.push(Match.new(chunk: chunk, similarity: similarity)) if similarity > minimum_similarity
      end
      matches
    end

    private

    attr_reader :input_area, :search_pattern_area, :minimum_similarity, :comparator
  end
end
