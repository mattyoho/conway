require 'conway/live_cell'
require 'conway/dead_cell'

module Conway
  module MemoizedCells
    def live_cell
      @live_cell ||= LiveCell.new
    end

    def dead_cell
      @dead_cell ||= DeadCell.new
    end
  end
end
