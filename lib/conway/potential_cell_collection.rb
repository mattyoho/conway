module Conway
  class PotentialCellCollection
    attr_reader :live_cell_lookup

    def initialize(live_locations)
      self.live_cell_lookup      = CellLocationLookup.new
      self.potential_cell_lookup = CellLocationLookup.new
      self.default_dead_cell     = DeadCell.new

      identify_potential_locations(live_locations)
    end

    def each_cell(&block)
      potential_cell_lookup.each do |cell_location|
        neighbor_cells = neighbor_cells_for(cell_location)

        next_cell = block.call(cell_location.cell, neighbor_cells)

        if next_cell.alive?
          live_cell_lookup.insert(cell_location)
        end
      end
    end

    private
    attr_accessor :potential_cell_lookup, :default_dead_cell
    attr_writer   :live_cell_lookup

    def identify_potential_locations(locations)
      locations.each do |loc|
        potential_cell_lookup.insert(loc)
        neighbors_for(loc).each do |neighbor|
          potential_cell_lookup.insert(neighbor)
        end
      end
    end

    def dead_cell_location(point)
      CellLocation.new(default_dead_cell, point)
    end

    def neighbors_for(location)
      location.adjacent_points.map do |point|
        potential_cell_lookup.retrieve(point) || dead_cell_location(point)
      end
    end

    def neighbor_cells_for(location)
      neighbors_for(location).map {|n| n.cell }
    end
  end
end
