# frozen_string_literal: true

module InvadersScanner
  class StringToBinaryConverter
    class UnknownCharError < StandardError; end

    class UnexpectedBinaryValue < StandardError; end

    POSITIVE_VALUE = '1'
    public_constant :POSITIVE_VALUE
    NEGATIVE_VALUE = '0'
    public_constant :NEGATIVE_VALUE
    END_LINE_CHAR = "\n"
    private_constant :END_LINE_CHAR
    POSITIVE_CHAR = 'o'
    private_constant :POSITIVE_CHAR
    NEGATIVE_CHAR = '-'
    private_constant :NEGATIVE_CHAR

    def initialize(string:, char_map: default_char_map, end_line_char: END_LINE_CHAR)
      @string = string
      @char_map = char_map
      @end_line_char = end_line_char
    end

    def call
      check_char_map
      raise UnknownCharError if string.match?(/[^#{allowed_chars.join}]/)

      char_map.each do |from_char, to_char|
        replace_string(from_char, to_char)
      end
      split_by_line
    end

    private

    attr_reader :string, :char_map, :end_line_char

    def default_char_map
      {
        NEGATIVE_CHAR => NEGATIVE_VALUE,
        POSITIVE_CHAR => POSITIVE_VALUE
      }
    end

    def allowed_chars
      char_map.map { |char, _| char } + [end_line_char]
    end

    def check_char_map
      char_map.each do |_, to|
        raise UnexpectedBinaryValue if to !~ /#{NEGATIVE_VALUE}|#{POSITIVE_VALUE}/
      end
    end

    def split_by_line
      string.split(end_line_char)
    end

    def replace_string(from, to)
      string.gsub!(from, to)
    end
  end
end
