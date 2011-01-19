class CellLocation
  attr_reader :cell, :point

  def initialize(cell, point)
    @cell  = cell
    @point = point
  end

  def adjacent_points
    point.adjacents
  end
end
