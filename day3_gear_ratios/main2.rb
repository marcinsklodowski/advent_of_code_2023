require 'pry'

file = File.open("input", "r")

def generate(lines)
  lines = ["." * lines.first.size] + lines + ["." * lines.first.size]

  lines.each do |line|
    line.scan(/\D/).each { |char| line.gsub!(char, "*") unless char == "." }
    line.prepend(".").concat(".")
  end

  lines.each_with_object([]) do |line, matrix|
    numbers = line.scan(/(?:\d+|.)/)
    matrix << numbers.each_with_object([]) do |number, row|
      number.length.times { |_| row << number }
      row
    end
    matrix
  end
end

sum = 0

lines = file.readlines.map(&:chomp)

lines = generate(lines)

lines.each_with_index do |line, idx|
  line.each_with_index do |char, idy|
    next unless char == "*"

    neighbords = [
      lines[idx - 1][idy],
      lines[idx - 1][idy - 1],
      lines[idx - 1][idy + 1],
      lines[idx][idy - 1],
      lines[idx][idy + 1],
      lines[idx + 1][idy - 1],
      lines[idx + 1][idy],
      lines[idx + 1][idy + 1],
    ]

    neighbords = neighbords.select { |n| n != "." && n != "*" }.map(&:to_i).uniq
    sum += neighbords.reduce(&:*) if neighbords.size == 2
  end
end

puts sum
