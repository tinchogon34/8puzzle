require "benchmark"
require "sqlite3"
require_relative '../lib/deep_clone'
require_relative '../lib/pieza.rb'
require_relative '../lib/puzzle.rb'
require_relative '../lib/jugada.rb'


def play
  profundidad, padre = 0, 0
  jugadas = []
  @puzzle = Puzzle.new(3,3,50)
  jugadas[profundidad] = [Jugada.new(@puzzle,nil)]
  until contiene_solucion?(jugadas[profundidad])
    profundidad += 1
    jugadas[profundidad] = []
    jugadas[profundidad-1].each do |p|
      vacio = p.puzzle.buscar_vacio
      
      p.puzzle.buscar_adyacentes(vacio).each do |pieza|
        pu = DeepClone.clone p.puzzle
        pu.mover!(pieza,pu.buscar_vacio)
        jugadas[profundidad].push(Jugada.new(pu,p))
      end
    end
  end
  p "salio joya"
end


def contiene_solucion?(profundidad)
  solucion = false
  profundidad.each { |jugada| solucion = true if jugada.puzzle.solucion?  }
  solucion
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



