require 'spec_helper'

include Conway

describe CellSpace do
  it "accepts a collection of points" do
    CellSpace.new [Point.new(0,0)]
  end

  describe "#apply" do
    let(:space)    { CellSpace.new [Point.new(0,0)] }
    let(:rule_set) { RuleSet.new }

    it "returns a CellLocationLookup" do
      space.apply(rule_set).should be_a_kind_of(CellLocationLookup)
    end
  end
end
