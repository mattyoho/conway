require "conway"

module Conway
  module Visualizer
    class Ascii
      def initialize(size, starting_cells, loop_interval=0.25)
        self.max_x = self.max_y = size
        self.starting_cells = starting_cells
        self.loop_interval  = loop_interval
      end

      def loop
        generation = Generation.new(starting_cells)
        start      = Time.now

        puts "They live!!\n\n"

        begin
          live_cells = generation.cell_coordinates

          if live_cells.count == 0
            puts "\nThey have all perished! D-:"
            break
          end

          grid = ""
          (1..max_y).each do |y|
            (1..max_x).each do |x|
              cell_char = cell_content_for(live_cells, x,y)
              grid << "|#{cell_char}"
            end
            grid << "|\n"
          end

          grid << "\n"

          grid <<  "Total objects: #{live_object_count} "
          grid <<  "Total living cells: #{live_cells.count}\n"

          elapsed_minutes, elapsed_seconds = ((Time.now - start).to_i).divmod 60
          grid << "Elapsed time: #{elapsed_minutes} min, #{elapsed_seconds} secs\n"

          yield grid if block_given?

          sleep(loop_interval)
        end while(generation = generation.next)
      end

      private
      attr_accessor :max_x, :max_y, :starting_cells, :loop_interval

      def cell_content_for(points, x,y)
        @comparison_point ||= Point.new(x,y)
        @comparison_point.update(x,y)
        points.detect {|p| p == @comparison_point } ? "X" : " "
      end

      def live_object_count
        if ObjectSpace.respond_to?(:count_objects)
          # Ruby 1.9.2
          ObjectSpace.count_objects[:TOTAL]
        else
          # Ruby 1.8.7
          ObjectSpace.live_objects
        end
      end
    end
  end
end
