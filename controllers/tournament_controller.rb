#encoding: utf-8

class Ranking < Sinatra::Application
  get '/tournaments' do
    slim :tournaments
  end
end