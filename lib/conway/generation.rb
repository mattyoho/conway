require 'conway/memoized_cells'

module Conway
  class Generation
    include Conway::MemoizedCells

    attr_accessor :location_lookup, :rules

    def initialize(points_or_lookup, rules=Rules.new)
      self.location_lookup = normalize_to_lookup points_or_lookup
      self.rules           = rules
    end

    def next
      cell_space   = CellSpace.new(location_lookup.locations)
      cell_lookup  = cell_space.apply(rules)
      Generation.new cell_lookup, rules
    end

    def cell_coordinates
      location_lookup.locations.map {|loc| loc.point }
    end

    private

    def normalize_to_lookup(points)
      return points unless points.kind_of?(Array)

      lookup = CellLocationLookup.new
      points.each do |point|
        loc = point_to_location(point)
        lookup.insert(loc)
      end

      lookup
    end

    def point_to_location(point)
      CellLocation.new(live_cell, point)
    end
  end
end
