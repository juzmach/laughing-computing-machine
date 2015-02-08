# encoding: utf-8

# Player Controller
class Ranking < Sinatra::Application

  get '/players' do
    slim :'players/players'
  end

  get 'players/:id' do
    slim :'players/show_player'
  end

end