require 'sinatra'

class Ranking < Sinatra::Application
	get '/' do
		erb :index
	end
end