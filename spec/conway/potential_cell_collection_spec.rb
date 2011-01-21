require 'spec_helper'

include Conway

describe PotentialCellCollection do
  let(:live_cell)     { LiveCell.new }
  let(:point)         { Point.new(1,1) }
  let(:cell_location) { CellLocation.new(live_cell, point) }
  let(:initial_cells) { [cell_location] }
  let(:collection)    { PotentialCellCollection.new(initial_cells) }

  describe "#each_cell" do
    it "yields the initial set of LiveCells" do
      yielded_cells = []
      collection.each_location do |cell, dont_care|
        yielded_cells << cell
        cell
      end
      yielded_cells.should include(cell_location)
    end

    context "neighbors" do
      let(:neighbor_cell)     { LiveCell.new }
      let(:neighbor_location) { CellLocation.new(neighbor_cell, Point.new(1,2)) }
      let(:initial_cells) do
        [CellLocation.new(live_cell, point), neighbor_location]
      end

      it "yields the neighboring LiveCells" do
        yielded_neighbors = nil
        collection.each_location do |cell, neighbors|
          yielded_neighbors = neighbors
          break
        end

        yielded_neighbors.should include(neighbor_location)
      end

      it "yields the neighboring locations with DeadCells" do
        yielded_neighbors = nil
        collection.each_location do |loc, neighbors|
          yielded_neighbors = neighbors
          break
        end

        (yielded_neighbors - [neighbor_location]).should have(7).neighbors
      end

      it "includes all neighboring DeadCells" do
        yielded_neighbors = nil
        collection.each_location do |cell, neighbors|
          yielded_neighbors = neighbors
          break
        end

        (yielded_neighbors - [neighbor_location]).any?{|c| c.kind_of?(LiveCell)}.should be_false
      end
    end
  end
end
