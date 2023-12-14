require 'pry'

patterns = File.open("input", "r").read.split("\n\n").map { _1.split("\n").map { |a| a.split("") } }

horizontal = []
vertical = []

def symmetrical?(left, right)
  length = [[left.size, right.size].min, 1].max
  left = left.reverse[0...length]
  right = right[0...length]
  left == right
end
def calculate_symmetries(pattern)
  symmetries = []
  pattern.each_with_index do |row, y|
    symmetries[y] ||= []
    row.each_with_index do |*, x|
      symmetries[y] << x if symmetrical?(row.slice(0...x), row.slice(x..))
    end
  end
  symmetries
end

patterns.each do |pattern|
  horizontal << calculate_symmetries(pattern).reduce(&:&)
  vertical << calculate_symmetries(pattern.transpose).reduce(&:&)
end

puts vertical.flatten.sum * 100 + horizontal.flatten.sum

