# frozen_string_literal: true

module InvadersScanner
  class Comparator2d
    def initialize(pattern_array, array)
      @pattern_array = pattern_array
      @array = array
    end

    def call
      similarity
    end

    private

    attr_reader :pattern_array, :array

    def similarity
      (100 - Float(count_positives(xor_arrays)) * 100 / Float(all_bits))
    end

    def all_bits
      pattern_array.join.chars.count
    end

    def count_positives(string)
      string.count('1')
    end

    def xor_arrays
      pattern_array.each_with_index
                   .map { |_, index| xor(index).to_s(2) }
                   .join
    end

    def xor(index)
      pattern_array[index].to_i(2) ^ array[index].to_i(2)
    end
  end
end
