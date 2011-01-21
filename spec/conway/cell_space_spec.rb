require 'spec_helper'

include Conway

describe CellSpace do
  it "accepts a collection of CellLocations" do
    CellSpace.new [CellLocation.new(LiveCell.new, Point.new(0,0))]
  end

  describe "#apply" do
    let(:cell)     { LiveCell.new }
    let(:location) { CellLocation.new(cell, Point.new(0,0)) }
    let(:space)    { CellSpace.new [location] }
    let(:rule_set) { RuleSet.new }

    it "returns a CellLocationLookup" do
      space.apply(rule_set).should be_a_kind_of(CellLocationLookup)
    end

    context "when the RuleSet gives a LiveCell" do
      let(:rule_set) { stub(:apply => LiveCell.new) }

      it "retains the cell" do
        live_cell_lookup = space.apply(rule_set)
        locations        = live_cell_lookup.locations

        locations.should have(9).locations

        locations.all? {|loc| loc.cell.alive? }.should be_true
      end
    end

    context "when the RuleSet gives a DeadCell" do
      let(:cell_location) { CellLocation.new(DeadCell.new, point) }
      let(:rule_set) { stub(:apply => DeadCell.new) }

      it "does not retain the cell" do
        live_cell_lookup = space.apply(rule_set)
        live_cell_lookup.should be_empty
      end
    end
  end

end
