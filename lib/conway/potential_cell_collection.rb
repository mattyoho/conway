module Conway
  class PotentialCellCollection
    def initialize(live_locations)
      identify_potential_locations(live_locations)
    end

    def each_cell(&block)
      potential_cell_locations.each do |point, cell_loc|
        neighbors      = neighbors_for(cell_loc)
        neighbor_cells = neighbors.map {|n| n.cell }

        next_cell = block.call(cell_loc.cell, neighbor_cells)

        if next_cell.alive?
          live_cell_locations[cell_loc.point] = cell_loc
        end
      end
    end

    def live_cell_lookup
      live_cell_locations
    end

    private

    def live_cell_locations
      @live_cell_locations ||= {}
    end

    def potential_cell_locations
      @potential_cell_locations ||= Hash.new do |hash, point|
        CellLocation.new(DeadCell.new, point)
      end
    end

    def identify_potential_locations(locations)
      locations.each do |loc|
        potential_cell_locations[loc.point] = loc
        neighbors_for(loc).each do |neighbor|
          potential_cell_locations[neighbor.point] = neighbor
        end
      end
    end

    def neighbors_for(location)
      location.adjacent_points.map do |point|
        potential_cell_locations[point]
      end
    end
  end
end
