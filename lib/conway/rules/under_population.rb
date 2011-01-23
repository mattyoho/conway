require 'conway/rules/live_count'

module Conway
  class Rules
    class UnderPopulation
      include Conway::Rules::LiveCount

      def apply(cell, neighbors)
        count = live_count(neighbors)
        dead_cell if cell.alive? && less_than_two?(count)
      end

      private

      def less_than_two?(count)
        count < 2
      end

      def dead_cell
        @dead_cell ||= DeadCell.new
      end
    end
  end
end
