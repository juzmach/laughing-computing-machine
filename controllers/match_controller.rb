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
      valid_match_date = validate_date(params[:match_date])
      unless valid_match_date[:result]
        session[:error_challenge] = "Match date #{valid_match_date[:message]}"
        redirect back
      end
      Team.create(params[:team_a_name],params[:team_a_id],nil)
      Team.create(params[:team_b_name],params[:team_b_id],nil)
      team_a = Team.find_by_player_id params[:team_a_id]
      team_b = Team.find_by_player_id params[:team_b_id]

      if params[:tournament_id].nil?
        Match.create(nil,1.0,team_a[:team_id],team_b[:team_id],params[:match_date],nil)
      else
        Match.create(params[:tournament_id],1.5,team_a[:team_id],team_b[:team_id],params[:match_date],'Confirmed')
      end
    end
    redirect '/'
  end

  get '/matches/:id/edit' do
    unless authenticated?
      session[:error_match_edit] = 'You need to be authenticated!'
      redirect back
    end
    @match = Match.find_by_id params[:id]
    @team_a = Team.find_by_id @match[:team_a_id]
    @team_b = Team.find_by_id @match[:team_b_id]
    slim :'matches/edit_match'
  end

  get '/matches/:id/confirm' do
    if authenticated?
      Match.confirm(params[:id])
    end
    redirect '/matches'
  end

  post '/matches/:id/edit' do
    if authenticated?
      valid_match_date = validate_date(params[:match_date])
      unless valid_match_date[:result]
        session[:error_match_edit] = "Match date #{valid_match_date[:message]}"
        redirect back
      end
      Match.update(params[:id],params[:match_date],'Pending')
    end
    redirect '/'
  end

  get '/matches/:id/end' do
    unless authenticated?
      session[:error_match_end] = 'You need to be authenticated!'
      redirect back
    end
    @match = Match.find_by_id params[:id]
    @team_a = Team.find_by_id @match[:team_a_id]
    @team_b = Team.find_by_id @match[:team_b_id]
    slim :'matches/end_match'
  end

  post '/matches/:id/end' do
    if authenticated?
      valid_team_a_score = validate_score params[:team_a_score].to_i
      valid_team_b_score = validate_score params[:team_b_score].to_i
      unless valid_team_a_score[:result]
        session[:error_match_end] = "Team A Score #{valid_team_a_score[:message]}"
        redirect back
      end
      unless valid_team_b_score[:result]
        session[:error_match_end] = "Team B Score #{valid_team_b_score[:message]}"
      end

      Match.end_match(params[:id],params[:team_a_score],params[:team_b_score])
    end
    redirect '/matches'
  end

  private

  def validate_score(score)
    Validator.not_below_zero? score
  end

  def validate_date(match_date)
    Validator.not_empty? match_date
  end
end