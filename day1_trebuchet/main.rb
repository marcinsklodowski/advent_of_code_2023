require "pry"
file = File.open("input", "r")

NUMBERS = {
  "one" => "one1one",
  "two" => "two2two",
  "three" => "three3three",
  "four" => "four4four",
  "five" => "five5five",
  "six" => "six6six",
  "seven" => "seven7seven",
  "eight" => "eight8eight",
  "nine" => "nine9nine"
}

def formatted_line(line)
  tmp = line.dup
  NUMBERS.each do |key, value|
    tmp.gsub!(key, value.to_s)
  end
  tmp
end

numbers = file.readlines.map(&:chomp).map do |line|
  digits = formatted_line(line).scan(/[1-9]{1}/)
  10 * digits.first.to_i + digits.last.to_i
end

puts numbers.sum