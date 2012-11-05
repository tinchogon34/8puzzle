require 'json'
require_relative 'lib/deep_clone'
require_relative 'lib/pieza'
require_relative 'lib/puzzle'
require_relative 'lib/movimiento'
require_relative 'lib/partida'

a = Partida.new
a.jugar
a.imprimir
