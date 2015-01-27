require 'sinatra'
require 'slim'
require './config/db_config.rb'

class Ranking < Sinatra::Application
	get '/' do
		slim :index
	end

	get '/players' do
		slim :players
	end

	get '/tournaments' do
		slim :tournaments
	end

	get '/matches' do
		slim :matches
	end

end
