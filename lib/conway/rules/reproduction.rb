require 'conway/rules/live_count'

module Conway
  class Rules
    class Reproduction
      include Conway::Rules::LiveCount
      include Conway::MemoizedCells

      def apply(cell, neighbors)
        count = live_count(neighbors)
        live_cell unless cell.alive? || fewer_or_greater_than_three?(count)
      end

      private

      def fewer_or_greater_than_three?(count)
        count != 3
      end
    end
  end
end
