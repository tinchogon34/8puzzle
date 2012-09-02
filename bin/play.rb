require "benchmark"
require_relative '../lib/deep_clone'
require_relative '../lib/pieza.rb'
require_relative '../lib/puzzle.rb'
require_relative '../lib/jugada.rb'


def play

  jugadas = []
  profundidad = 0
  puzzle = Puzzle.new(3,3)
  jugadas[profundidad] = [puzzle]
  
  vacio = puzzle.buscar_vacio
  puzzle.buscar_adyacentes(vacio).times do |i|
    p = DeepClone.clone puzzle
    
    p.mover!(p.buscar_adyacentes(p.buscar_vacio), p.buscar_vacio)
    jugadas[profundidad].push(p)
  end
  p puzzle
  p jugadas[0]
end

play

#p = Puzzle.new(3,3)

#p.busqueda_anchura


#Benchmark.bm do |b|
#  b.report("Ordenar Random:") { p.ordenar_random! }
#  print "Cantidad de pasos: " + p.pasos.to_s + "\n"
#  b.report("Ordenar Cuasi-Random:") { u.ordenar_cuasirandom! }
#  print "Cantidad de pasos: " + u.pasos.to_s + "\n"
#end



