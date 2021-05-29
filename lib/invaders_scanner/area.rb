# frozen_string_literal: true

module InvadersScanner
  class Area
    class OutOfAreaException < StandardError; end

    attr_reader :array_value

    def self.from_string(string, converter: StringToBinaryConverter)
      Area.new(converter.new(string: string).call)
    end

    def initialize(array_value, start_coordinate: Coordinate.new(0, 0))
      @array_value = array_value
      @min_coordinate = start_coordinate
      @comparator = comparator
    end

    def max_coordinate
      Coordinate.new(width_size - 1, height_size - 1)
    end

    def chunk(start_coordinate, size_coordinate)
      end_coordinate = start_coordinate + size_coordinate

      raise OutOfAreaException if end_coordinate > max_coordinate

      Area.new(
        array_value[start_coordinate.y..end_coordinate.y].map { |elem| elem[start_coordinate.x..end_coordinate.x] },
        start_coordinate: start_coordinate
      )
    end

    def each_chunk(size_coordinate, start_coordinate: min_coordinate)
      start_coordinate.each_until(max_coordinate - size_coordinate) do |coordinate|
        yield(chunk(coordinate, size_coordinate))
      end
    end

    private

    attr_reader :min_coordinate, :comparator

    def width_size
      array_value.map { |elem| elem.chars.count }
                 .max
    end

    def height_size
      array_value.count
    end
  end
end
