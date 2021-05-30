# frozen_string_literal: true

module InvadersScanner
  class Scanner
    attr_reader :matches

    DEFAULT_MINIMUM_SIMILARITY = 80
    private_constant :DEFAULT_MINIMUM_SIMILARITY

    def initialize(input:, search_pattern:, minimum_similarity: DEFAULT_MINIMUM_SIMILARITY, comparator: AreaComparator)
      @input_area = input
      @search_pattern_area = search_pattern
      @minimum_similarity = minimum_similarity
      @comparator = comparator
      reset_matches
    end

    def scan
      reset_matches
      input_area.each_chunk(search_pattern_area.max_coordinate) do |chunk|
        similarity = comparator.new(chunk, search_pattern_area).call
        matches.push(Match.new(chunk: chunk, similarity: similarity)) if similarity > minimum_similarity
      end
      matches
    end

    private

    attr_reader :input_area, :search_pattern_area, :minimum_similarity, :comparator

    def reset_matches
      @matches = []
    end
  end
end
