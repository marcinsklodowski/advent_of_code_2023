require 'pry'

map = File.open("input", "r").read.split("\n").map { _1.split("") }
map = [Array.new(map.first.size) { "." }] + map + [Array.new(map.first.size) { "." }]
map = map.map { ["."] + _1 + ["."] }

def find_start(map)
  map.each_with_index do |row, y|
    row.each_with_index do |col, x|
      return [x, y] if col == "S"
    end
  end
end

initial_x, initial_y = find_start(map)

x = initial_x
y = initial_y
queue_counter = 0

queue = [[y, x, 0]]
loop do
  x, y, steps = queue.shift
  queue_counter += 1

  if map[x][y] == "S"
    queue << [x + 1, y, steps + 1] if %w[| J L].include?(map[x + 1][y])
    queue << [x - 1, y, steps + 1] if %w[| F 7].include?(map[x - 1][y])
    queue << [x, y + 1, steps + 1] if %w[- J 7].include?(map[x][y + 1])
    queue << [x, y - 1, steps + 1] if %w[- F L].include?(map[x][y - 1])
  end

  if map[x][y] == "|"
    queue << [x - 1, y, steps + 1] if %w[| F 7].include?(map[x - 1][y])
    queue << [x + 1, y, steps + 1] if %w[| J L].include?(map[x + 1][y])
  end

  if map[x][y] == "J"
    queue << [x, y - 1, steps + 1] if %w[- F L].include?(map[x][y - 1])
    queue << [x - 1, y, steps + 1] if %w[| 7 F].include?(map[x - 1][y])
  end

  if map[x][y] == "L"
    queue << [x, y + 1, steps + 1] if %w[- J 7].include?(map[x][y + 1])
    queue << [x - 1, y, steps + 1] if %w[| 7 F].include?(map[x - 1][y])
  end

  if map[x][y] == "F"
    queue << [x, y + 1, steps + 1] if %w[- J 7].include?(map[x][y + 1])
    queue << [x + 1, y, steps + 1] if %w[| J L].include?(map[x + 1][y])
  end

  if map[x][y] == "7"
    queue << [x, y - 1, steps + 1] if %w[- F L].include?(map[x][y - 1])
    queue << [x + 1, y, steps + 1] if %w[| J L].include?(map[x + 1][y])
  end

  if map[x][y] == "-"
    queue << [x, y - 1, steps + 1] if %w[- F L].include?(map[x][y - 1])
    queue << [x, y + 1, steps + 1] if %w[- J 7].include?(map[x][y + 1])
  end

  map[x][y] = "*"

  break if queue.empty?
end

puts "queue_counter: #{queue_counter / 2}"

