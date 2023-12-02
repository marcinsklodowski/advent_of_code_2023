file = File.open("input", "r")

counts = []

file.readlines.map(&:chomp).each do |line|
  counts << line.scan(/\d+ red/).map(&:to_i).max * line.scan(/\d+ green/).map(&:to_i).max *
    line.scan(/\d+ blue/).map(&:to_i).max
end

puts counts.sum