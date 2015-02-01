#encoding: utf-8

# Main Controller
class Ranking < Sinatra::Application
  get '/' do
    slim :index
  end

  get '/register' do
    slim :register
  end

  post '/signin' do
  end
end