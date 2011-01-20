require 'spec_helper'

include Conway

describe CellSpace do
  it "accepts a collection of points" do
    CellSpace.new [Point.new(0,0)]
  end

  describe "#apply" do
    let(:space)    { CellSpace.new [Point.new(0,0)] }
    let(:rule_set) { RuleSet.new }

    it "returns a set of Points" do
      space.apply(rule_set).all?{|p| p.kind_of?(Point)}.should be_true
    end
  end
end
