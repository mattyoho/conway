module Conway
  class CellSpace
    def initialize(locations)
      self.potential_cells = PotentialCellCollection.new(locations)
    end

    def apply(rule_set)
      live_cell_lookup = CellLocationLookup.new
      potential_cells.each_location do |location, neighbors|
        cell = rule_set.apply(location.cell, neighbors.map{|n| n.cell })
        if cell.alive?
          live_cell_lookup.insert(CellLocation.new(cell, location.point))
        end
      end
      live_cell_lookup
    end

    private
    attr_accessor :potential_cells
  end
end
