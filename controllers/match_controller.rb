#encoding: utf-8

class Ranking < Sinatra::Application
  get '/matches' do
    slim :'matches/matches'
  end

  post '/matches/new' do
    if authenticated?
      if params[:tournament_id].nil?
        Team.create()
        Match.create(nil,1.0,params[:team_a_id],params[:team_b_id],params[:match_date])
      else
        Match.create(params[:tournament_id],1.5,params[:team_a_id],params[:team_b_id],params[:match_date])
      end
    end
    redirect '/'
  end

end