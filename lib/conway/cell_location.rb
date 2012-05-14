module Conway
  class CellLocation
    attr_accessor :cell, :point

    def initialize(cell, point)
      self.cell  = cell
      self.point = point
    end

    def adjacent_points
      point.adjacents
    end
  end
end
