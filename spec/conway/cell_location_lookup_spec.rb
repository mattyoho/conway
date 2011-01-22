require 'spec_helper'

include Conway

describe CellLocationLookup do
  let(:point)    { Point.new 1,1 }
  let(:cell)     { LiveCell.new }
  let(:location) { CellLocation.new cell, point }
  let(:lookup)   { CellLocationLookup.new }

  describe "#initialize" do
    context "given a block" do
      it "uses the block for default returns from #retrieve" do
        lookup = CellLocationLookup.new {|p| "Point: (#{p.x},#{p.y})" }
        lookup.retrieve(point).should eql("Point: (1,1)")
      end
    end
  end

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

  describe "#each" do
    let(:point2)    { Point.new 2,2 }
    let(:location2) { CellLocation.new cell, point2 }

    before do
      lookup.insert location
      lookup.insert location2
    end

    it "yields each location once" do
      locations = []
      lookup.each do |loc|
        locations << loc
      end

      locations.should have(2).locations
      locations.should include(location)
      locations.should include(location2)
    end
  end

  describe "#locations" do
    let(:point2)    { Point.new 2,2 }
    let(:location2) { CellLocation.new cell, point2 }

    before do
      lookup.insert location
      lookup.insert location2
    end

    it "is all the contained locations" do
      lookup.locations.should have(2).locations
      lookup.locations.should include(location)
      lookup.locations.should include(location2)
    end
  end

  describe "#count" do
    let(:point2)    { Point.new 2,2 }
    let(:location2) { CellLocation.new cell, point2 }

    before do
      lookup.insert location
      lookup.insert location2
    end

    it "is the number of contained locations" do
      lookup.count.should == 2
    end
  end

  describe "#empty?" do
    context "when the count is 0" do
      it { should be_empty }
    end

    context "when the count is 1" do
      before { subject.insert location }
      it { should_not be_empty }
    end
  end
end
