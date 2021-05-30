# frozen_string_literal: true

module InvadersScanner
  class AreaConverter
    def initialize(string:, normalizer: Normalizer, converter: StringToBinaryConverter)
      @string = string
      @normalizer = normalizer
      @converter = converter
    end

    def call
      convert
    end

    private

    attr_reader :string, :normalizer, :converter

    def convert
      converter.new(string: normalize).call
    end

    def normalize
      normalizer.new(string: string).call
    end
  end
end
