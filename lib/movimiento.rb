class Movimiento

  attr_reader :puzzle, :padre, :direccion
  attr_writer :padre, :direccion
  def initialize(puzzle,padre, direccion)
    @puzzle, @padre, @direccion = puzzle, padre, direccion
  end
end
