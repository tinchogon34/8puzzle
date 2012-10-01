class Jugada

  attr_reader :puzzle, :padre

  def initialize(puzzle,padre)
    @puzzle, @padre = puzzle, padre
  end
end
