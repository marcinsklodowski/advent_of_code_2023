require 'pry'

data = []
File.open("input", "r").read.split("\n").each do |row|
  data << row.split(" ").map(&:to_i)
end

subdatas = []
data.each do |row|
  subdata = [row.reverse] # i just love how this is the only difference between this and the part 1 solution
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

puts subdatas.map { |subdata| subdata.first.last }.sum

