require 'sinatra'

class Ranking < Sinatra::Application
	get '/' do
		erb :index
	end

	get '/players' do
		erb :players
	end

	get '/tournaments' do
		erb :tournaments
	end
end
