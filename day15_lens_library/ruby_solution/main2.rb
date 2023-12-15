require 'pry'

steps = File.open("input", "r").read.split(",")

def ascii_hash(input)
  input.codepoints.reduce(0) { |sum, char| ((sum + char) * 17) % 256 }
end

boxes = Array.new(256) { [] }
steps.each do |step|
  label = step.match(/[a-z]*/)[0]
  action = step.match(/[\=\-]/)[0]
  box_id = ascii_hash(label)
  if action == "="
    value = step.match(/\d/)[0].to_i
    if boxes[box_id].find { |box| box[:label] == label }
      boxes[box_id].find { |box| box[:label] == label }[:value] = value
    else
      boxes[box_id] << { label: label, value: value }
    end
  else
    boxes[box_id].delete_if { |box| box[:label] == label }
  end
end

sum = 0
boxes.each_with_index do |box, box_index|
  box.each_with_index do |item, item_index|
    sum += item[:value] * (box_index + 1) * (item_index + 1)
  end
end

puts sum