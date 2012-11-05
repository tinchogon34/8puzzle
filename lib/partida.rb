class Partida
  def jugar
    @profundidad, padre, @pasos = 0, 0, 0
    @movimientos = []
    @movimientos2 = []
    puzzle = Puzzle.new(3,3,50)
    puzzle2 = Puzzle.new(3,3)
    @movimientos[@profundidad] = [Movimiento.new(puzzle,nil, nil)]
    @movimientos2[@profundidad] = [Movimiento.new(puzzle2,nil, nil)]
    @lista = [puzzle.label]
    @lista2 = [puzzle2.label]
    until interseccion?
      @profundidad += 1
      puts @profundidad
      @movimientos[@profundidad] = []
      @movimientos2[@profundidad] = []

      @movimientos[@profundidad-1].each do |movimiento|
        vacio = movimiento.puzzle.buscar_vacio
        movimiento.puzzle.buscar_adyacentes(vacio).each do |pieza|
          new_puzzle = DeepClone.clone movimiento.puzzle
          new_puzzle.mover!(new_puzzle.buscar_valor(pieza.valor), new_puzzle.buscar_vacio)
          unless @lista.include?(new_puzzle.label)
            @movimientos[@profundidad] << Movimiento.new(new_puzzle,movimiento, pieza.direccion)
            @lista << new_puzzle.label
          end
        end
      end

      @movimientos2[@profundidad-1].each do |movimiento|
        vacio = movimiento.puzzle.buscar_vacio
        movimiento.puzzle.buscar_adyacentes(vacio).each do |pieza|
          new_puzzle = DeepClone.clone movimiento.puzzle
          new_puzzle.mover!(new_puzzle.buscar_valor(pieza.valor), new_puzzle.buscar_vacio)
          unless @lista2.include?(new_puzzle.label)
            @movimientos2[@profundidad] << Movimiento.new(new_puzzle,movimiento, pieza.direccion)
            @lista2 << new_puzzle.label
          end
        end
      end
    end
  end

  def interseccion?
     interseccion = false
     @lista.each { |item| interseccion = true if @lista2.include?(item) }
     interseccion
  end

  def contiene_solucion?
    solucion = false
    @movimientos[@profundidad].each { |movimiento| solucion = true if movimiento.puzzle.solucion? }
    solucion
  end
  def imprimir
    m1 = nil
    m2 = nil
    @movimientos.each do |profundidad|
      profundidad.each do |movimiento|
        if @lista2.include? movimiento.puzzle.label
          m1 = movimiento
        end
      end
    end
    @movimientos2.each do |profundidad|
      profundidad.each do |movimiento|
        if movimiento.puzzle.label == m1.puzzle.label
          m2 = movimiento
        end
      end
    end
    solucion = []
    while m2.padre
      if m2.direccion == 'derecha'
       m2.direccion = 'izquierda'
      elsif m2.direccion == 'izquierda'
        m2.direccion = 'derecha'
      elsif m2.direccion == 'abajo'
        m2.direccion = 'arriba'
      else
        m2.direccion = 'abajo'
      end
      solucion << m2.direccion
      m2 = m2.padre
    end
    solucion.reverse!
    while m1.padre
      solucion << m1.direccion
      m1 = m1.padre
    end
    puts [@movimientos[0].first.puzzle.to_json].concat solucion
    [@movimientos[0].first.puzzle.to_json].concat solucion
  end
end
