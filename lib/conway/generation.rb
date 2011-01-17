class Generation
  attr_reader :cells

  def initialize(cells=[])
    @cells = cells
  end

  def next
    new_cells = cells.map {|c| c.evolve }
    Generation.new new_cells
  end
end
