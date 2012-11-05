require 'sinatra'
require 'json'
require_relative '../lib/deep_clone'
require_relative '../lib/pieza'
require_relative '../lib/puzzle'
require_relative '../lib/movimiento'
require_relative '../lib/partida'

set :public_folder, 'public'

before do
  content_type :json
end

get '/' do
  content_type :html
  @partida = Partida.new
  @partida.jugar
  erb :resultado
end

get '/resultado' do
  @partida.imprimir
end
