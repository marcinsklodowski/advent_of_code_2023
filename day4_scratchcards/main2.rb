require 'pry'

lines = File.open("input", "r")
            .readlines.map(&:chomp)
            .map { |a| a.split(":").last }
            .map { |a| a.split("|") }
            .map { |line| [1, (line[0].split(" ").map(&:to_i) & line[1].split(" ").map(&:to_i)).size] }

lines.each_with_index do |(cards_number, matches_number), index|
  cards_number.times { matches_number.times { |match_idx| lines[index + match_idx + 1][0] += 1 } }
end

puts lines.map(&:first).sum
