require 'pry'
input = File.read('input_test')
seeds, *maps = input.split("\n\n")
seeds = seeds.split[1..].map(&:to_i)
maps = maps.map { _1.split.map(&:to_i)[2..] }


conv = seeds.map do |seed|
  maps.reduce(seed) do |s, ms1|
    binding.pry
    msf = ms1.each_slice(3).find { |(_, a, l)| s >= a && s < a + l }
    msf ? s - msf[1] + msf[0] : s
  end
end

print('Part 1: ', conv.min)



22222222
input = File.read('input.txt')
seeds, *maps = input.split("\n\n")
seeds = seeds.split[1..].map(&:to_i).each_slice(2).map { _1.._1 + _2 }
$maps = maps.map { |m| m.split.map(&:to_i)[2..].each_slice(3).map { [_2.._2 + _3, _1 - _2] } }

def convSeeds(seeds, i)
  return [seeds] unless $maps[i]

  conv = $maps[i].find { seeds.intersect?(_1[0]) }
  newseeds = conv ? [(seeds & conv[0]) + conv[1], *seeds.split(conv[0])] : [seeds]
  newseeds.flat_map { convSeeds(_1, i + 1) }
end

print('Part 2: ', seeds.flat_map { convSeeds(_1, 0) }.map(&:begin).min)