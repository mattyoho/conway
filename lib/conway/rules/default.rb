module Conway
  class Rules
    class Default
      include Conway::MemoizedCells

      def apply(cell, neighbors)
        dead_cell
      end
    end
  end
end
