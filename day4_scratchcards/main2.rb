require 'pry'

lines = File.open("input", "r")
            .readlines.map(&:chomp)
            .map { |a| a.split(":").last }.map { |a| a.split("|") }

map = []
lines.map do |line|
  map << [1, (line[0].split(" ").map(&:to_i) & line[1].split(" ").map(&:to_i)).size]
end

map.each_with_index do |line, index|
  cards_number, matches_number = line

  cards_number.times do
    matches_number.times do |match_idx|
      map[index + match_idx + 1][0] += 1
    end
  end
end

puts map.map(&:first).sum
