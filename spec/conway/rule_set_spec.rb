require 'spec_helper'

include Conway

describe RuleSet do
  let(:rule_set) { RuleSet.new }
  describe "#apply" do
    context "when a DeadCell" do
      let(:cell) { DeadCell.new }

      it "returns a LiveCell when there are three live neighbors" do
        new_cell = rule_set.apply(cell, [LiveCell.new] * 3)
        new_cell.should be_alive
      end

      it "returns a DeadCell with fewer than three live neighbors" do
        new_cell = rule_set.apply(cell, [LiveCell.new] * 2)
        new_cell.should_not be_alive
      end
    end

    context "when a LiveCell" do
      let(:cell) { LiveCell.new }
      it "returns a DeadCell when underpopulated" do
        rule_set.apply(cell, [DeadCell.new] * 8).should_not be_alive
      end

      it "returns a LiveCell when sufficiently populated" do
        new_cell = rule_set.apply(cell, [LiveCell.new] * 2)
        new_cell.should be_alive
      end

      it "returns a LiveCell when sufficiently populated" do
        new_cell = rule_set.apply(cell, [LiveCell.new] * 3)
        new_cell.should be_alive
      end

      it "returns a DeadCell when over-populated" do
        new_cell = rule_set.apply(cell, [LiveCell.new] * 4)
        new_cell.should_not be_alive
      end
    end
  end
end
