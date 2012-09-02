require "benchmark"
require_relative '../lib/pieza.rb'
require_relative '../lib/puzzle.rb'

p = Puzzle.new(3,3)
u = Puzzle.new(3,3)

u.piezas = p.piezas.map { |p| p.valor }

Benchmark.bm do |b|
  b.report("Ordenar Random:") { p.ordenar_random! }
  print "Cantidad de pasos: " + p.pasos.to_s + "\n"
  b.report("Ordenar Cuasi-Random:") { u.ordenar_cuasirandom! }
  print "Cantidad de pasos: " + u.pasos.to_s + "\n"
end



