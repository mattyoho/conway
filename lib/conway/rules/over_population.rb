require 'conway/rules/live_count'

module Conway
  class Rules
    class OverPopulation
      include Conway::Rules::LiveCount
      include Conway::MemoizedCells

      def apply(cell, neighbors)
        count = live_count(neighbors)
        dead_cell if cell.alive? && greater_than_three?(count)
      end

      private

      def greater_than_three?(count)
        count > 3
      end
    end
  end
end

