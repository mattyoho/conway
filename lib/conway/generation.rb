module Conway
  class Generation
    attr_reader :cell_coordinates, :rule_set

    def initialize(cell_coordinates=[], rule_set=RuleSet.new)
      @cell_coordinates = cell_coordinates
      @rule_set         = rule_set
    end

    def next
      cell_space = CellSpace.new(cell_coordinates)
      new_coords = cell_space.apply(rule_set).map{|loc| loc.point }
      Generation.new new_coords, rule_set
    end
  end
end
