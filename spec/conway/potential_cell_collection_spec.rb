require 'spec_helper'

include Conway

describe PotentialCellCollection do
  let(:live_cell)     { LiveCell.new }
  let(:point)         { Point.new(1,1) }
  let(:cell_location) { CellLocation.new(live_cell, point) }
  let(:initial_cells) { [cell_location] }
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

    context "when the cell is a LiveCell" do
      it "does not retain the cell if it becomes a DeadCell" do
        collection.each_cell do |cell, neighbors|
          DeadCell.new
        end
        collection.live_cell_lookup.should be_empty
      end

      it "retains the cell if it remains a LiveCell" do
        collection.each_cell do |cell, neighbors|
          LiveCell.new
        end
        collection.live_cell_lookup.locations.should include(cell_location)
      end
    end

    context "when the cell is a DeadCell" do
      let(:cell_location) { CellLocation.new(DeadCell.new, point) }

      it "does not retain the cell if it remains a DeadCell" do
        collection.each_cell do |cell, neighbors|
          DeadCell.new
        end
        collection.live_cell_lookup.should be_empty
      end

      it "retains the cell if it remains a LiveCell" do
        collection.each_cell do |cell, neighbors|
          LiveCell.new
        end
        collection.live_cell_lookup.locations.should include(cell_location)
      end
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
        yielded_neighbors = nil
        collection.each_cell do |cell, neighbors|
          yielded_neighbors = neighbors
          break
        end

        (yielded_neighbors - [neighbor_cell]).any?{|c| c.alive?}.should be_false
      end
    end
  end
end
