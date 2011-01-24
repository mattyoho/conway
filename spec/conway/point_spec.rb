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

    it "memoizes the points" do
      point.adjacents
      Point.should_receive(:new).never
      point.adjacents
    end
  end

  describe "#update" do
    let(:point) { Point.new(2,2) }
    it "updates the x and y points" do
      point.update(1,3)
      point.x.should eql(1)
      point.y.should eql(3)
    end

    it "returns self" do
      point.update(4,2).should equal(point)
    end

    it "clears the adjacents cache" do
      point.adjacents
      point.instance_variable_get("@adjacents").should_not be_nil
      point.update(0, 0)
      point.instance_variable_get("@adjacents").should be_nil
    end
  end
end

