#encoding: utf-8

# Main Controller
class Ranking < Sinatra::Application
  get '/' do
    slim :index
  end
end