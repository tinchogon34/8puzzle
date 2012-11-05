class Pieza

  attr_accessor :valor, :fila, :columna, :direccion
  attr_writer :direccion
  def initialize(valor,fila,columna, direccion)
    @valor, @fila, @columna, @direccion = valor, fila, columna, direccion
  end
end
