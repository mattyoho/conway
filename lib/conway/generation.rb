module Conway
  class Generation
    attr_reader :location_lookup

    def initialize(cell_locations, rule_set=RuleSet.new)
      self.location_lookup = normalize_to_lookup cell_locations
      self.rule_set        = rule_set
    end

    def next
      cell_space   = CellSpace.new(cell_coordinates)
      cell_lookup  = cell_space.apply(rule_set)
      Generation.new cell_lookup, rule_set
    end

    def cell_coordinates
      location_lookup.locations.map {|loc| loc.point }
    end

    private
    attr_accessor :rule_set
    attr_writer   :location_lookup

    def normalize_to_lookup(locations)
      return locations unless locations.kind_of?(Array)

      lookup = CellLocationLookup.new
      locations.each do |loc|
        loc = point_to_location(loc) if loc.kind_of?(Point)
        lookup.insert(loc)
      end

      lookup
    end

    def point_to_location(point)
      @live_cell ||= LiveCell.new
      CellLocation.new(@live_cell, point)
    end
  end
end
