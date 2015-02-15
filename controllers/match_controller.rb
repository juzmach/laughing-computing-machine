#encoding: utf-8

class Ranking < Sinatra::Application
  get '/matches' do
    @matches = Match.all
    @teams = Team.all
    @tournaments = Tournament.all
    slim :'matches/matches'
  end

  post '/matches/new' do
    if authenticated?
      Team.create(params[:team_a_name],params[:team_a_id],nil)
      Team.create(params[:team_b_name],params[:team_b_id],nil)
      team_a = Team.find_by_player_id params[:team_a_id]
      team_b = Team.find_by_player_id params[:team_b_id]

      if params[:tournament_id].nil?
        Match.create(nil,1.0,team_a[:id],team_b[:id],params[:match_date])
      else
        Match.create(params[:tournament_id],1.5,team_a[:id],team_b[:id],params[:match_date])
      end
    end
    redirect '/'
  end

end