file = File.open("input", "r")

cubs = [12, 13, 14]
lines = file.readlines.map(&:chomp)
counts = []

lines.each do |line|
  counts << [
    line.scan(/\d+ red/).map(&:to_i).max,
    line.scan(/\d+ green/).map(&:to_i).max,
    line.scan(/\d+ blue/).map(&:to_i).max
  ]
end

sum = 0
counts.each_with_index do |count, index|
  sum += index + 1 if count[0] <= cubs[0] && count[1] <= cubs[1] && count[2] <= cubs[2]
end

puts sum