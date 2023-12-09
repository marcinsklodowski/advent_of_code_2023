require 'pry'

steps, links = File.open("input", "r").read.split("\n\n")

map = {}
links.split("\n").each do |link|
  map[link[0..2]] = { "L" => link[7..9], "R" => link[12..14] }
end

current_position = "AAA"
steps_index = 0
steps_count = 0
while current_position != "ZZZ"
  steps_count += 1
  current_step = steps[steps_index]
  current_position = map[current_position][current_step]
  steps_index == steps.size - 1 ? steps_index = 0 : steps_index += 1
end

puts steps_count
