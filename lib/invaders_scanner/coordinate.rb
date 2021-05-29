# frozen_string_literal: true

module InvadersScanner
  class Coordinate
    class UnexpectedUntilCoordinate < StandardError; end

    include Comparable

    attr_accessor :x_param, :y_param

    alias x x_param
    alias y y_param

    def initialize(x_param, y_param)
      @x_param = x_param
      @y_param = y_param
    end

    def to_a
      [x_param, y_param]
    end

    def +(other)
      Coordinate.new(x_param + other.x_param, y_param + other.y_param)
    end

    # The other coordinate is smaller only when it's in first quarter based on current coordinate
    def <=>(other)
      if x_param == other.x_param && y_param == other.y_param
        0
      elsif other.x_param <= x_param && other.y_param <= y_param
        1
      else
        -1
      end
    end

    # Iterates until reaches coordinate
    def each_until(coordinate)
      raise UnexpectedUntilCoordinate if coordinate < self

      (y_param..coordinate.y).each do |j|
        (x_param..coordinate.x).each do |i|
          yield(Coordinate.new(i, j))
        end
      end
    end
  end
end
