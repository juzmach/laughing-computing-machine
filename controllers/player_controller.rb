# encoding: utf-8

# Player Controller
class Ranking < Sinatra::Application

  get '/players' do
    @players = Player.all
    slim :'players/players'
  end

  get '/players/:id' do
    @player = Player.find_by_id params[:id]
    @matches = Match.players_matches params[:id]
    @teams = Team.all
    slim :'players/show_player'
  end

  get '/players/:id/challenge' do
    @player = Player.find_by_id params[:id]
    slim :'players/challenge_player'
  end

end