module Conway
  class CellSpace
    attr_accessor :potential_cells

    def initialize(locations)
      self.potential_cells = PotentialCellCollection.new(locations)
    end

    def apply(rules, live_cell_lookup = CellLocationLookup.new)
      potential_cells.each_location do |location, neighbors|
        cell = rules.apply(location.cell, neighbors.map{|n| n.cell })
        if cell.alive?
          live_cell_lookup.insert(CellLocation.new(cell, location.point))
        end
      end
      live_cell_lookup
    end

  end
end
