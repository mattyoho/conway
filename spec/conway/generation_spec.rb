require 'spec_helper'

include Conway

describe Generation do
  let(:coordinates) { [Point.new(0,0), Point.new(1,1)] }
  let(:generation)  { Generation.new(coordinates) }

  describe "#initialize" do
    it "accepts an array of Points" do
      expect { generation.next }.to_not raise_error
    end

    it "accepts an array of CellLocations" do
      generation = Generation.new([CellLocation.new(LiveCell.new, Point.new(1,1))])
      expect { generation.next }.to_not raise_error
    end

    it "accepts a CellLocationLookup" do
      generation = Generation.new(CellLocationLookup.new)
      expect { generation.next }.to_not raise_error
    end
  end

  describe "#cell_coordinates" do
    it "returns points of current live cells" do
      generation.cell_coordinates.should have(2).points
      generation.cell_coordinates.should == coordinates
    end
  end

  describe '#next' do
    it 'returns the next Generation' do
      generation.next.should be_a_kind_of(Generation)
    end

    it "that generation doesn't blow up" do
      next_generation = generation.next
      expect { next_generation.next }.to_not raise_error
    end
  end
end
