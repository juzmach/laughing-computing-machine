#encoding: utf-8

class Ranking < Sinatra::Application
  get '/tournaments' do
    @tournaments = Tournament.all
    slim :'tournaments/tournaments'
  end

  get '/tournaments/new' do
    slim :'tournaments/add_tournament'
  end

  get '/tournaments/:id' do
    @tournament = Tournament.find_by_id params[:id]
    @tournament_teams = Tournament.tournament_teams params[:id]
    @admin = Player.find_by_id @tournament[:admin_id]
    slim :'tournaments/show_tournament'
  end

  post '/tournaments/new' do
    if authenticated?
      Tournament.create(params[:name],params[:start_date],params[:start_time],params[:end_date],params[:end_time],params[:location],session[:user_id])
    end
    redirect '/'
  end

  get '/tournaments/:id/join' do
    if authenticated?
      Tournament.join(params[:id],session[:username],session[:user_id])
    end
    redirect "/tournaments/#{params[:id]}"
  end

  get '/tournaments/:id/leave' do
    if authenticated?
      Tournament.leave(params[:id],session[:user_id])
    end
    redirect "tournaments/#{params[:id]}"
  end
end