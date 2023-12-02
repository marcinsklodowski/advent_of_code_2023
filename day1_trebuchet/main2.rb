file = File.open("input", "r")

MAPPING = {
  "zero" => 0,
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "eigth" => 8,
  "nine" => 9
}

lines = file.readlines.map(&:chomp)

numbers = lines.map do |line|
  first_idx = line.size
  first_value = nil

  MAPPING.each do |word, _|
    idx = line.index(word)
    if idx && idx < first_idx
      first_idx = idx
      first_value = MAPPING[word]
    end
  end

  (1..9).each do |digit|
    idx = line.index(digit.to_s)
    if idx && idx < first_idx
      first_idx = idx
      first_value = digit
    end
  end

  last_idx = first_idx
  last_value = first_value
  MAPPING.each do |word, _|
    idx = line.rindex(word)
    if idx && idx > last_idx
      last_idx = idx
      last_value = MAPPING[word]
    end
  end

  (1..9).each do |digit|
    idx = line.rindex(digit.to_s)
    if idx && idx > last_idx
      last_idx = idx
      last_value = digit
    end
  end

  "#{first_value}#{last_value}".to_i
end

puts numbers.sum