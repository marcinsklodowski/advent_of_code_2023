require 'pry'

steps, links = File.open("input", "r").read.split("\n\n")

map = {}
links.split("\n").sort.each do |link|
  map[link[0..2]] = { "L" => link[7..9], "R" => link[12..14]}
end

current_positions = []
map.each { |position, *| current_positions << position if position[2] == "A" }

steps_index = 0
steps_count = 0
cycle_lengths = Array.new(current_positions.size) { 0 }

while cycle_lengths.include?(0)
  steps_count += 1
  current_positions.each_with_index do |current_position, idx|
    current_step = steps[steps_index]
    current_positions[idx] = map[current_position][current_step]
    cycle_lengths[idx] = steps_count if current_positions[idx][2] == "Z"
  end

  steps_index == steps.size - 1 ? steps_index = 0 : steps_index += 1
end

puts cycle_lengths.reduce(1, :lcm)

