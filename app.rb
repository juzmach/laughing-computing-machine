require 'sinatra'
require 'slim'
require './config/db_config.rb'

class Ranking < Sinatra::Application
	get '/' do
		slim :index
	end

	get '/players' do
		erb :players
	end

	get '/tournaments' do
		erb :tournaments
	end
end
