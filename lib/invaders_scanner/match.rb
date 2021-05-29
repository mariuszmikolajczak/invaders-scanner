# frozen_string_literal: true

module InvadersScanner
  class Match
    def initialize(matched_chunk:, similarity:)
      @matched_chunk = matched_chunk
      @similarity = similarity
    end

    def coordinates
      [matched_chunk.min_coordinate, matched_chunk.max_coordinate]
    end

    private

    attr_reader :matched_chunk, :similarity
  end
end
