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
          new_points = generation.cell_coordinates

          if new_points.count == 0
            puts "\nThey have all perished! D-:"
            break
          end

          grid = ""
          (1..max_y).each do |y|
            (1..max_x).each do |x|
              cell_char = cell_content_for(new_points, x,y)
              grid << "|#{cell_char}"
            end
            grid << "|\n"
          end

          grid << "\n"

          grid <<  "Total objects: #{ObjectSpace.count_objects[:TOTAL]} "
          grid <<  "Total LiveCells: #{new_points.count}\n"

          elapsed_minutes, elapsed_seconds = ((Time.now - start).to_i).divmod 60
          grid << "Elapsed time: #{elapsed_minutes} min, #{elapsed_seconds} secs\n"

          yield grid if block_given?

          sleep(loop_interval)
        end while(generation = generation.next)
      end

      private
      attr_accessor :max_x, :max_y, :starting_cells, :loop_interval

      def cell_content_for(points, x,y)
        points.detect {|p| p.x == x && p.y == y } ? "X" : " "
      end
    end
  end
end
