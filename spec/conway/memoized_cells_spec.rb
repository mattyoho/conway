require 'spec_helper'

describe Conway::MemoizedCells do
  let(:klass)    { Class.new.tap {|c| c.send(:include, Conway::MemoizedCells) } }
  let(:instance) { klass.new }
  describe "#live_cell" do
    it "is alive" do
      instance.live_cell.should be_alive
    end

    it "returns the same object across invocations" do
      instance.live_cell.should equal(instance.live_cell)
    end
  end

  describe "#dead_cell" do
    it "is not alive" do
      instance.dead_cell.should_not be_alive
    end

    it "returns the same object across invocations" do
      instance.dead_cell.should equal(instance.dead_cell)
    end
  end
end
