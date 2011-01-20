require 'spec_helper'

describe Conway::LiveCell do

  it "lives" do
    Conway::LiveCell.new.should be_alive
  end
end
