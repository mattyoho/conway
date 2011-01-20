require 'spec_helper'

include Conway

describe CellLocationLookup do
  let(:point)    { Point.new 1,1 }
  let(:cell)     { LiveCell.new }
  let(:location) { CellLocation.new cell, point }
  let(:lookup)   { CellLocationLookup.new }

  describe "#insert" do
    it "accepts a CellLocation" do
      lookup.insert location
    end
  end

  describe "#retrieve" do
    before { lookup.insert location }

    it "looks up based on a point" do
      lookup.retrieve(point).should eql(location)
    end

    it "looks up based on x,y" do
      lookup.retrieve(1,1).should eql(location)
    end
  end
end
