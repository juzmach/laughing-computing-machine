# encoding: utf-8

# Player Controller
class Ranking < Sinatra::Application

  get '/players' do
    @players = Player.all
    slim :'players/players'
  end

  get '/players/:id' do
    @player = Player.find_by_id params[:id]
    slim :'players/show_player'
  end

end