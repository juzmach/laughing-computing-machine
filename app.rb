require 'sinatra'

class RPGDB < Sinatra::Application
	get '/' do
		erb :index
	end
end