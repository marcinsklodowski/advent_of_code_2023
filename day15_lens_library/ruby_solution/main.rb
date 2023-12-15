steps = File.open("input", "r").read.split(",")
puts steps.map { |step| step.codepoints.reduce(0) { |sum, char| ((sum + char) * 17) % 256 } }.reduce(:+)
