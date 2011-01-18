require 'spec_helper'

describe DeadCell do

  it "lives not" do
    DeadCell.new.should_not be_alive
  end

end
