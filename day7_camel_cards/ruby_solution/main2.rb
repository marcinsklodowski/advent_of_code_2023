require 'pry'

hands = File.open("input", "r").read.split("\n")

def compare_cards(a, b)
  ["A", "K", "Q", "J", "T"].each do
    return 1 if a == _1
    return -1 if b == _1
  end
  return 1 if a > b
  return -1 if a < b
  0
end

def hand_value(hand)
  return 7 if hand == "JJJJJ"

  hand_without_jokers = hand.chars.reject { _1 == "J" }.sort { |a, b| compare_cards(a, b) }.reverse
  counts_without_jokers = hand_without_jokers.map { hand_without_jokers.count(_1) }
  max_count_without_jokers = counts_without_jokers.max
  to_replace = counts_without_jokers.index(max_count_without_jokers)

  hand = hand.gsub("J", hand_without_jokers[to_replace])
  counts = hand.chars.map { hand.count(_1) }

  return 7 if counts.include?(5)
  return 6 if counts.include?(4)
  return 5 if counts.include?(3) && counts.include?(2)
  return 4 if counts.include?(3)

  two_counts = counts.select { _1 == 2 }.size
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

  fhand1 = hand1.chars.map { |a| a.gsub("T", "10").gsub("J", "1").gsub("Q", "12").gsub("K", "13").gsub("A", "14") }.map(&:to_i)
  fhand2 = hand2.chars.map { |a| a.gsub("T", "10").gsub("J", "1").gsub("Q", "12").gsub("K", "13").gsub("A", "14") }.map(&:to_i)

  fhand1.each_with_index do |card, idx|
    return -1 if card < fhand2[idx]
    return 1 if card > fhand2[idx]
  end
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
