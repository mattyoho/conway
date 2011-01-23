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
    let(:rules)    { Rules.new }

    it "returns a CellLocationLookup" do
      space.apply(rules).should be_a_kind_of(CellLocationLookup)
    end

    context "when the Rules gives a LiveCell" do
      let(:rules) { stub(:apply => LiveCell.new) }

      it "retains the cell" do
        live_cell_lookup = space.apply(rules)
        locations        = live_cell_lookup.locations

        locations.should have(9).locations

        locations.all? {|loc| loc.cell.alive? }.should be_true
      end
    end

    context "when the Rules gives a DeadCell" do
      let(:cell_location) { CellLocation.new(DeadCell.new, point) }
      let(:rules)         { stub(:apply => DeadCell.new) }

      it "does not retain the cell" do
        live_cell_lookup = space.apply(rules)
        live_cell_lookup.should be_empty
      end
    end
  end

end
