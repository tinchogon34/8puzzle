class Pieza

  attr_accessor :valor, :fila, :columna

  def initialize(valor,fila,columna)
    @valor, @fila, @columna = valor, fila, columna
  end
end
