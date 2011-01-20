module Conway
  class CellSpace
    def initialize(points)
      self.potential_cells = PotentialCellCollection.new(live_locations(points))
    end

    def apply(rule_set)
      potential_cells.each_cell do |cell, neighbors|
        rule_set.apply(cell, neighbors)
      end
      potential_cells.live_cell_lookup.values
    end

    private
    attr_accessor :potential_cells

    def live_locations(points)
      points.map do |point|
        CellLocation.new(LiveCell.new, point)
      end
    end
  end
end
