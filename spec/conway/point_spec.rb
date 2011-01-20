require 'spec_helper'

include Conway

describe Point do
  let(:point) { Point.new 1,2 }

  it "has x,y coordinates" do
    point.x.should eql(1)
    point.y.should eql(2)
  end

  describe "equality" do
    it "should equal another point with the same coordinates" do
      Point.new(1,2).should eql(Point.new(1,2))
      Point.new(1,2).should ==  Point.new(1,2)
    end
  end

  describe "#adjacents" do
    let(:point) { Point.new(2,2) }
    let(:neighbors) do
      [Point.new(1,1),
       Point.new(2,1),
       Point.new(3,1),
       Point.new(1,2),
       Point.new(3,2),
       Point.new(1,3),
       Point.new(2,3),
       Point.new(3,3)]
    end

    it "returns the eight adjacent points" do
      point.adjacents.should == neighbors
    end
  end

  describe "#update" do
    let(:point) { Point.new(2,2) }
    it "updates the x and y points" do
      point.update(1,3)
      point.x.should eql(1)
      point.y.should eql(3)
    end
  end
end

