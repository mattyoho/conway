require "conway"

Signal.trap("TERM") do
  puts "Exiting..."
  exit
end

Signal.trap("INT") do
  puts "Exiting..."
  exit
end

START = Time.now
MAX_X = 30
MAX_Y = 30

points = [Point.new(1,4),
          Point.new(3,3),
          Point.new(4,3),
          Point.new(4,4),
          Point.new(6,4),
          Point.new(7,4)]

generation = Generation.new(points)

begin
  new_points = generation.cell_coordinates
  #max_x = new_points.collect {|p| p.x}.max
  #max_y = new_points.collect {|p| p.y}.max

  grid = ""
  (1..MAX_Y).each do |y|
    (1..MAX_X).each do |x|
      char = new_points.detect {|p| p == Point.new(x, y)} ? "X" : " "
      grid << "|#{char}"
    end
    grid << "|\n"
  end

  puts grid

  object_stats =  "Total objects: #{ObjectSpace.count_objects[:TOTAL]} "
  object_stats << "Total LiveCells: #{new_points.count}"
  puts object_stats

  elapsed_minutes, elapsed_seconds = ((Time.now - START).to_i).divmod 60
  puts "Elapsed time: #{elapsed_minutes} min, #{elapsed_seconds} secs"

  puts ''
  sleep(0.25)
end while(generation = generation.next)
