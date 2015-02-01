#encoding: utf-8

# Main Controller
class Ranking < Sinatra::Application
  get '/' do
    slim :index
  end

  get '/register' do
    slim :register
  end

  get '/signin' do
  end
end