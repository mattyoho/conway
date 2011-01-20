require 'spec_helper'

include Conway

describe CellLocation do
  let(:cell_location) { CellLocation.new(LiveCell.new, Point.new(1,1)) }

  it "has a cell" do
    cell_location.cell.should be_a_kind_of(LiveCell)
  end

  it "has a point" do
    cell_location.point.should be_a_kind_of(Point)
  end

  describe "#adjacent_points" do
    it "is returns its point's adjacents" do
      cell_location.adjacent_points.should == Point.new(1,1).adjacents
    end
  end
end
