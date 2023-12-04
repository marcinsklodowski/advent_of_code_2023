require 'pry'

file = File.open("input", "r")

lines = file.readlines.map(&:chomp).map { |a| a.split(":").last }.map { |a| a.split("|") }

res = lines.map do |line|
  winning, my = line.map { |a| a.split(" ").map(&:to_i) }
  match = my & winning
  match.size.zero? ? 0 : 2 ** (match.size - 1)
end

puts res.sum

