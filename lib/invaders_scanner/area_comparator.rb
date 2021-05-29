# frozen_string_literal: true

module InvadersScanner
  class AreaComparator
    def initialize(first_area, second_area, comparator: Comparator2d)
      @first_area = first_area
      @second_area = second_area
      @comparator = comparator
    end

    def call
      comparator.new(first_area.array_value, second_area.array_value).call
    end

    private

    attr_reader :first_area, :second_area, :comparator
  end
end
