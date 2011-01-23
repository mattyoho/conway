require 'spec_helper'

include Conway

describe Rules::Default do
  let(:rule)      { Rules::Default.new }
  let(:cell)      { }
  let(:neighbors) { }

  it "returns nil" do
    rule.apply(cell, neighbors).should_not be_alive
  end
end
