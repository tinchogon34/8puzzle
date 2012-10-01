class Puzzle

  attr_reader	:piezas, :pasos, :filas, :columnas
  
  def initialize(filas,columnas,desordenar_n = 0)
    v = 0
    @filas, @columnas = filas, columnas
    @piezas = []
    filas.times do |i|
      columnas.times do |j|
        @piezas << Pieza.new(v+=1,i,j)
      end
    end
    @piezas[-1] = Pieza.new(0,filas-1,columnas-1)
    desordenar!(desordenar_n) if desordenar_n > 0
  end

  def desordenar!(n)
    n.times do
      vacio = buscar_vacio
      adyacentes = buscar_adyacentes(vacio)
      mover!(adyacentes[rand(adyacentes.size)], vacio)
    end
  end

  def piezas=(p)
    (@filas*@columnas).times{ |i| @piezas[i].valor = p[i] }
  end

  def buscar_valor(x)
    @piezas.each { |pieza| return pieza if pieza.valor == x }
    return nil
  end

  def buscar_posicion(fila,columna)
    @piezas.each { |pieza| return pieza if pieza.fila == fila &&
                  pieza.columna == columna }
    return nil
  end
  def buscar_vacio
    buscar_valor(0)
  end

  def buscar_adyacentes(pieza)
    p1 = buscar_posicion(pieza.fila-1,pieza.columna)
        p2 = buscar_posicion(pieza.fila,pieza.columna+1)
        p3 = buscar_posicion(pieza.fila+1,pieza.columna)
        p4 = buscar_posicion(pieza.fila,pieza.columna-1)
    [p1,p2,p3,p4].compact
  end

  def mover!(origen, destino)
    origen.valor, destino.valor = destino.valor, origen.valor
  end

  def solucion?
    @piezas.map { |pieza| pieza.valor } == (1..piezas.size-1).to_a.push(0)
  end

  def to_s
    puzzle = ""		
    (@filas*@columnas).times do |i|
      puzzle << ((i+1) % @filas == 0 ? @piezas[i].valor.to_s + "  |  " + "\n" 
                 : @piezas[i].valor.to_s + "  |  ")			
    end
    puzzle
  end

  def label
    @piezas.map { |pieza| pieza.valor }.join
  end
end

