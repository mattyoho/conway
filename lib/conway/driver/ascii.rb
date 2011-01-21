require "conway"

module Conway
  module Driver
    class Ascii
      def initialize(size, starting_cells, loop_interval=0.25)
        self.max_x          = self.max_y = size
        self.starting_cells = starting_cells
        self.loop_interval  = loop_interval
      end

      def loop
        generation = Generation.new(starting_cells)
        start      = Time.now

        puts "They live!!\n\n"

        begin
          lookup = generation.location_lookup

          grid =  generate_grid(lookup)

          grid << current_stats(lookup)
          grid << elapsed_time_since(start)


          yield grid if block_given?

          if lookup.empty?
            puts "\nThey have all perished! D-:"
            break
          end

          sleep(loop_interval)
        end while(generation = generation.next)
      end

      private
      attr_accessor :max_x, :max_y, :starting_cells, :loop_interval

      def generate_grid(lookup)
        grid = ""
        (1..max_y).each do |y|
          (1..max_x).each do |x|
            cell_char = cell_content_for(lookup, x, y)
            grid << "|#{cell_char}"
          end
          grid << "|\n"
        end
        grid
      end

      def cell_content_for(lookup, x,y)
        lookup.retrieve(x,y) ? "X" : " "
      end

      def current_stats(lookup)
        stats =  "Total objects: #{live_object_count} "
        stats << "Total living cells: #{lookup.count}\n"
      end

      def elapsed_time_since(start)
        elapsed_minutes, elapsed_seconds = ((Time.now - start).to_i).divmod 60
        "Elapsed time: #{elapsed_minutes} min, #{elapsed_seconds} secs\n"
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
