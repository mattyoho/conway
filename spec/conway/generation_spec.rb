require 'spec_helper'

describe Generation do
  let(:generation) { Generation.new }

  describe '#next' do
    it 'returns the next Generation' do
      generation.next.should be_a_kind_of(Generation)
    end

    describe "cellular evolution" do
      let(:cells) do
        (1..3).map {|n| stub.tap {|s| s.should_receive(:evolve).and_return(:"cell#{n}") } }
      end

      before { generation.stub(:cells => cells) }

      it "tells its cells to evolve" do
        generation.next
      end

      it "provides the evolved cells to the next generation" do
        new_cells = generation.next.cells
        new_cells.should == [:cell1, :cell2, :cell3]
      end
    end
  end
end
