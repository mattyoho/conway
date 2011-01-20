require 'spec_helper'

include Conway

describe PotentialCellCollection do
  let(:live_cell)     { LiveCell.new }
  let(:point)         { Point.new(1,1) }
  let(:initial_cells) { [CellLocation.new(live_cell, point)] }
  let(:collection)    { PotentialCellCollection.new(initial_cells) }

  describe "#each_cell" do
    it "contains the initial set of LiveCells" do
      yielded_cells = []
      collection.each_cell do |cell, dont_care|
        yielded_cells << cell
        cell
      end
      yielded_cells.should include(live_cell)
    end

    it "removes LiveCells that become DeadCells" do
      collection.each_cell do |cell, neighbors|
        DeadCell.new
      end
      collection.live_cell_locations.should be_empty
    end

    context "neighbors" do
      let(:neighbor_cell) { LiveCell.new }
      let(:initial_cells) do
        [CellLocation.new(live_cell, point),
         CellLocation.new(neighbor_cell, Point.new(1,2))]
      end

      it "yields the neighboring LiveCells" do
        yielded_neighbors = nil
        collection.each_cell do |cell, neighbors|
          yielded_neighbors = neighbors
          break
        end

        yielded_neighbors.should include(neighbor_cell)
      end

      it "yields the neighboring DeadCells" do
        yielded_neighbors = nil
        collection.each_cell do |cell, neighbors|
          yielded_neighbors = neighbors
          break
        end

        (yielded_neighbors - [neighbor_cell]).should have(7).neighbors
      end

      it "includes all neighboring DeadCells" do

      end
    end
  end
end
