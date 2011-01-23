require 'spec_helper'

include Conway

describe Rules do
  describe "#apply" do
    let(:cell)      { LiveCell.new }
    let(:neighbors) { [LiveCell.new] }
    let(:a_rule)    { stub }
    let(:b_rule)    { stub }
    let(:c_rule)    { stub }
    let(:rule_set)  { [a_rule, b_rule, c_rule] }
    let(:rules)     { Rules.new(rule_set) }

    it "calls apply for each sub rule" do
      rule_set.each {|r| r.should_receive(:apply).with(cell, neighbors) }
      rules.apply(cell, neighbors)
    end

    context "return value" do
      let(:a_rule)    { stub(:apply => nil) }
      let(:b_rule)    { stub(:apply => :b) }
      let(:c_rule)    { stub(:apply => :c) }

      it "returns the first non-nil result" do
        rules.apply(cell, neighbors).should == :b
      end
    end
  end
end
