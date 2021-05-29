# frozen_string_literal: true

module InvadersScanner
  class Match
    attr_reader :similarity

    def initialize(chunk:, similarity:)
      @chunk = chunk
      @similarity = similarity
    end

    def coordinates
      [chunk.min_coordinate, chunk.max_coordinate]
    end

    private

    attr_reader :chunk
  end
end
