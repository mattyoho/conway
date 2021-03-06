module Conway
  class Point
    attr_accessor :x, :y

    def initialize(x=0,y=0)
      self.x, self.y = x,y
    end

    def eql?(other)
      self.x == other.x && self.y == other.y
    end

    def ==(other)
      eql? other
    end

    def hash
      :"#{x}-#{y}".object_id
    end

    def update(x, y)
      self.x     = x
      self.y     = y
      @adjacents = nil

      self
    end

    def adjacents
      @adjacents ||=
      (-1..1).map do |j|
        (-1..1).map do |i|
          Point.new(x+i, y+j) unless i == 0 && j == 0
        end
      end.flatten.compact
    end

  end
end
