module Conway
  class PotentialCellCollection
    def initialize(live_locations)
      self.potential_cell_lookup = CellLocationLookup.new do |point|
        CellLocation.new(default_dead_cell, point)
      end

      insert_potential_locations(live_locations)
    end

    def each_location(&block)
      potential_cell_lookup.each do |cell_location|
        neighbor_locations = neighbors_for(cell_location)

        block.call(cell_location, neighbor_locations)
      end
    end

    private
    attr_accessor :potential_cell_lookup

    def insert_potential_locations(locations)
      locations.each do |loc|
        potential_cell_lookup.insert(loc)
        neighbors_for(loc).each do |neighbor|
          potential_cell_lookup.insert(neighbor)
        end
      end
    end

    def neighbors_for(location)
      location.adjacent_points.map do |point|
        potential_cell_lookup.retrieve(point)
      end
    end

    def default_dead_cell
      @dead_cell ||= DeadCell.new
    end
  end
end
