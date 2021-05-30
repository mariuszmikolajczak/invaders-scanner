# frozen_string_literal: true

module InvadersScanner
  class Normalizer
    class AllowedCharsMismatchError < StandardError; end

    def initialize(string:, allowed_chars: %w[- o \n], change_others_to: 'o')
      @string = string
      @allowed_chars = allowed_chars
      @change_others_to = change_others_to
    end

    def call
      check_params
      return string unless string.match?(/[^#{allowed_chars.join}]/)

      string.gsub(/[^#{allowed_chars.join}]/, change_others_to)
    end

    private

    attr_reader :string, :allowed_chars, :change_others_to

    def check_params
      raise AllowedCharsMismatchError unless allowed_chars.include?(change_others_to)
    end
  end
end
