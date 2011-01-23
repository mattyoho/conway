require 'conway/rules/live_count'

module Conway
  class Rules
    class Stability
      include Conway::Rules::LiveCount
      include Conway::MemoizedCells

      def apply(cell, neighbors)
        count = live_count(neighbors)
        live_cell if cell.alive? && two_or_three?(count)
      end

      private

      def two_or_three?(count)
        count == 2 || count == 3
      end
    end
  end
end
