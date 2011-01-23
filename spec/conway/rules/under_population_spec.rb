require 'spec_helper'

include Conway

describe Rules::UnderPopulation do
  let(:rule) { Rules::UnderPopulation.new }

  context "when a DeadCell" do
    let(:cell) { DeadCell.new }

    context "with a bunch of live neighbors" do
      let(:neighbors) { [LiveCell.new] * 8 }

      it "returns nil" do
        rule.apply(cell, neighbors).should be_nil
      end
    end

    context "with a bunch of dead neighbors" do
      let(:neighbors) { [DeadCell.new] * 8 }

      it "returns nil" do
        rule.apply(cell, neighbors).should be_nil
      end
    end
  end

  context "when a LiveCell" do
    let(:cell) { LiveCell.new }

    context "with less than two live neighbors" do
      let(:neighbors) { [DeadCell.new] * 7 + [LiveCell.new] }

      it "returns a DeadCell" do
        rule.apply(cell, neighbors).should_not be_alive
      end
    end

    context "with two live neighbors" do
      let(:neighbors) { [DeadCell.new] * 6 + [LiveCell.new] * 2 }

      it "returns nil" do
        rule.apply(cell, neighbors).should be_nil
      end
    end

    context "with more than two live neighbors" do
      let(:neighbors) { [DeadCell.new] * 5 + [LiveCell.new] * 3 }

      it "returns nil" do
        rule.apply(cell, neighbors).should be_nil
      end
    end
  end
end
