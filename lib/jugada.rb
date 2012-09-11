class Jugada

  attr_reader :puzzle

  def initialize(puzzle,padre)
    @puzzle, @padre = puzzle, padre
  end

end
