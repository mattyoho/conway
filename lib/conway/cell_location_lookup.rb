module Conway
  class CellLocationLookup
    def initialize(&block)
      @hash  ||= block_given? ? Hash.new {|h,p| yield p } : {}
      @point ||= Point.new(0,0)
    end

    def insert(cell_location)
      @hash[cell_location.point] = cell_location
    end

    def retrieve(point_or_x, y=nil)
      point_or_x = @point.update(point_or_x, y) if y

      @hash[point_or_x]
    end

    def locations
      @hash.values
    end

    def count
      locations.count
    end

    def empty?
      !(count > 0)
    end

    def each(&block)
      locations.each(&block)
    end
  end
end
