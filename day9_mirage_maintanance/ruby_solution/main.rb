require 'pry'

data = []
File.open("input", "r").read.split("\n").each do |row|
  data << row.split(" ").map(&:to_i)
end

subdatas = []
data.each do |row|
  subdata = [row]
  loop_idx = 0
  loop do
    subdata << Array.new(subdata.last.size - 1) { 0 }
    subdata[loop_idx + 1].each_with_index do |_, idx|
      subdata.last[idx] = subdata[loop_idx][idx + 1] - subdata[loop_idx][idx]
    end
    break if subdata.last.uniq == [0]
    loop_idx += 1
  end
  subdatas << subdata
end

subdatas.each do |subdata|
  subdata.reverse.each_with_index do |row, idx|
    if idx == 0
      row << 0
    else
      row << row.last + subdata.reverse[idx - 1].last
    end
  end
end

sum = 0
subdatas.each { |subdata| sum += subdata.first.last }

puts sum
