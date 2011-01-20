require 'spec_helper'

describe Conway::DeadCell do

  it "lives not" do
    Conway::DeadCell.new.should_not be_alive
  end

end
