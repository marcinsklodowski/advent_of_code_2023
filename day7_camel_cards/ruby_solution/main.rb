require 'pry'

hands = File.open("input", "r").read.split("\n")

def hand_value(hand)
  counts = hand.chars.map { |c| hand.count(c) }
  return 7 if counts.include?(5)
  return 6 if counts.include?(4)
  return 5 if counts.include?(3) && counts.include?(2)
  return 4 if counts.include?(3)

  two_counts = counts.select { _1 == 2}.size
  return 3 if two_counts == 4
  return 2 if two_counts == 2
  1
end

def compare_hands(a, b)
  hand1 = a.split(" ").first
  hand1_value = hand_value(hand1)
  hand2 = b.split(" ").first
  hand2_value = hand_value(hand2)

  return 1 if hand1_value > hand2_value
  return -1 if hand1_value < hand2_value

  fhand1 = hand1.chars.map { |a| a.gsub("T", "10").gsub("J", "14").gsub("Q", "11").gsub("K", "12").gsub("A", "13") }.map(&:to_i)
  fhand2 = hand2.chars.map { |a| a.gsub("T", "10").gsub("J", "14").gsub("Q", "11").gsub("K", "12").gsub("A", "13") }.map(&:to_i)

  return -1 if fhand1[0] < fhand2[0]
  return 1 if fhand1[0] > fhand2[0]
  return -1 if fhand1[1] < fhand2[1]
  return 1 if fhand1[1] > fhand2[1]
  return -1 if fhand1[2] < fhand2[2]
  return 1 if fhand1[2] > fhand2[2]
  return -1 if fhand1[3] < fhand2[3]
  return 1 if fhand1[3] > fhand2[3]
  return -1 if fhand1[4] < fhand2[4]
  return 1 if fhand1[4] > fhand2[4]
  0
end

sum = 0
hands.sort { |a, b| compare_hands(a, b) }
     .each_with_index do |hand, idx|
  bid = hand.split(" ").last
  puts "#{ hand.split(" ").first} value: #{hand_value(hand.split(" ").first)} rank: #{idx + 1}, bid: #{bid}"
  sum += bid.to_i * (idx + 1)
end

puts sum
