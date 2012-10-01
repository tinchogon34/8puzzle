require "benchmark"
require_relative '../lib/deep_clone'
require_relative '../lib/pieza'
require_relative '../lib/puzzle'
require_relative '../lib/jugada'

def play
  @profundidad, padre, @pasos = 0, 0, 0
  @jugadas = []
  puzzle = Puzzle.new(3,3,50)
  @jugadas[@profundidad] = [Jugada.new(puzzle,nil)]
  lista = [puzzle.label]
  until contiene_solucion?
    @profundidad += 1
    @jugadas[@profundidad] = []
    @jugadas[@profundidad-1].each do |jugada|
      vacio = jugada.puzzle.buscar_vacio
      jugada.puzzle.buscar_adyacentes(vacio).each do |pieza|
        new_puzzle = DeepClone.clone jugada.puzzle
        new_puzzle.mover!(new_puzzle.buscar_valor(pieza.valor), new_puzzle.buscar_vacio)
        @pasos += 1
        unless lista.include?(new_puzzle.label)
          @jugadas[@profundidad] << Jugada.new(new_puzzle,jugada)
          lista << new_puzzle.label
        end
      end
    end
  end
end

def contiene_solucion?
  solucion = false
  @jugadas[@profundidad].each { |jugada| solucion = true if jugada.puzzle.solucion? }
  solucion
end

def imprimir
  jugada = @jugadas[@profundidad].select { |jugada| jugada.puzzle.solucion? }.first
  solucion = [jugada.puzzle]
  while jugada.padre
    solucion << jugada.padre.puzzle
    jugada = jugada.padre
  end
  puts solucion.reverse.join("\n")
  puts "Cantidad de pasos: #{solucion.size - 1}"
  puts "Pasos: #{@pasos}"
end

Benchmark.bm do |b|
  b.report("Busqueda en anchura:") { play }
end

imprimir
