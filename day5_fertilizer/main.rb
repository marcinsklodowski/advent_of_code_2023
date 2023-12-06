require 'pry'

file = File.open("input", "r")
lines = file.read
lines.split("\n\n").map { _1.lines(chomp: true) } => [seeds], *maps
seeds = seeds.scan(/\d+/).map(&:to_i)

class Vertex
  attr_reader :value, :edges, :name

  def initialize(name, value)
    @name = name
    @value = value
    @edges = []
  end

  def add_edge(edge)
    edges << edge
  end
end

class Edge
  attr_reader :source, :destination, :value

  def initialize(source:, value:, destination:)
    @source = source
    @value = value
    @destination = destination
  end
end

class Graph
  attr_reader :vertices, :edges

  def initialize
    @vertices = {}
  end

  def add_edge(edge)
    if vertices[edge.source] == nil
      vertices[edge.source] = Vertex.new(edge.source, edge.source.split("_").last)
    end
    if vertices[edge.destination] == nil
      vertices[edge.destination] = Vertex.new(edge.destination, edge.value)
    end
    vertices[edge.source].add_edge(edge)
  end
end

graph = Graph.new

tops = {
  seed: 0,
  location: 0,
  fertilizer: 0,
  soil: 0,
  water: 0,
  light: 0,
  temperature: 0,
  humidity: 0
}
maps.each do |map|
  source = map[0].split("-")[0]
  destination = map[0].split("-")[2].split(" ")[0]

  map.each do |line|
    to, from, range = line.scan(/\d+/).map(&:to_i)

    next if from == nil

    # puts
    # puts
    # puts "Line #{line}"
    # puts
    #
    tops[source.to_sym] = range + from if tops[source.to_sym] < range + from
    tops[destination.to_sym] = range + to if tops[source.to_sym] < range + to

    (0...range).each do |i|
      # puts "Adding edge from #{source}_#{from + i} to #{destination}_#{to + i}, value #{to + i}"
      graph.add_edge(
        Edge.new(
          value: from + i,
          source: "#{source}_#{from + i}",
          destination: "#{destination}_#{to + i}",
        )
      )
    end
  end
end
puts
puts

map = {
  "seed" => "soil",
  "soil" => "fertilizer",
  "fertilizer" => "water",
  "water" => "light",
  "light" => "temperature",
  "temperature" => "humidity",
  "humidity" => "location"
}

tops.each do |source, top|
  destination = map[source.to_s]
  next unless destination
  (0..top+1000).each do |i|
    if graph.vertices["#{source}_#{i}"].nil?
      # puts "Adding edge from #{source}_#{i} to #{destination}_#{i}, value #{i}"

      graph.add_edge(
        Edge.new(
          value: i,
          source: "#{source}_#{i}",
          destination: "#{destination}_#{i}"
        )
      )
    end
  end
end

#
# binding.pry

graph.vertices.map { |key, *| key }.each do |key|

  if graph.vertices[key].edges.empty?
    graph.add_edge(
      Edge.new(
        value: key.split("_").last.to_i,
        source: key,
        destination: "#{map[key.split("_").first]}_#{key.split("_").last}"
      )
    )
  end
end

queue = []
locations = {}

seeds.each do |seed|
  # puts "adding #{graph.vertices["seed_#{seed}"].name} to queue"
  queue << graph.vertices["seed_#{seed}"].name

  while queue.any?
    vertex_name = queue.shift
    vertex = graph.vertices[vertex_name]
    vertex.edges.each do |edge|
      if edge.destination.match(/location/)
        locations["seed_#{seed}"] ||= []
        locations["seed_#{seed}"] << edge.value
      end
      # puts "adding #{edge.destination} to queue"
      queue << edge.destination
    end
  end
end

# puts graph

binding.pry
