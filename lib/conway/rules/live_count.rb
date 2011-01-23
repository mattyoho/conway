module Conway
  class Rules
    module LiveCount
      private

      def live_count(neighbors)
        neighbors.count {|n| n.alive? }
      end
    end
  end
end
