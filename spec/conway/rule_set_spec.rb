require 'spec_helper'

describe RuleSet do
  let(:rule_set) { RuleSet.new }
  let(:cell)     { DeadCell.new }
  describe "#apply" do
    it "returns a cell based on a cell and a set of neighbor cells" do
      rule_set.apply(cell, [])
    end
  end
end
