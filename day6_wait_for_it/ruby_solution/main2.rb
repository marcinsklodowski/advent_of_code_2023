require 'pry'

data = File.open("input2", "r").read.split("\n\n").map { _1.lines(chomp: true) }.first
times, distances = data.map { |a| a.split(":").last }.map { |a| a.split(" ").map(&:to_i) }
records = Array.new(times.size, 0)

0.upto(times.size - 1) do |race_number|
  0.upto(times[race_number]) do |try_time|
    records[race_number] += 1 if (times[race_number] - try_time) * try_time > distances[race_number]
  end
end

puts records.reduce(:*)
