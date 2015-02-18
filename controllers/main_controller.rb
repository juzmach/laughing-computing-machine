#encoding: utf-8
require 'bcrypt'

# Main Controller
class Ranking < Sinatra::Application
  get '/' do
    @players_top10 = Player.top10
    @latest_tournaments = Tournament.latest_tournaments
    @latest_matches = Match.latest_matches
    @teams = Team.all
    slim :'main/index'
  end

  get '/register' do
    slim :'main/register'
  end

  post '/register' do
    valid_username = validate(params[:username],3)
    valid_password = validate(params[:password],8)
    valid_name = validate(params[:name],3)
    unless valid_username[:result]
      session[:error_register] = "Username #{valid_username[:message]}"
      redirect back
    end
    unless valid_password[:result]
      session[:error_register] = "Password #{valid_password[:message]}"
      redirect back
    end
    unless valid_name[:result]
      session[:error_register] = "Name #{valid_name[:message]}"
      redirect back
    end
      password = BCrypt::Password.create(params[:password])
      Player.create params[:username],password, params[:name]
      redirect '/'
  end

  post '/signin' do
    user = Player.find_by_username(params[:username])
    unless user.nil?
      if BCrypt::Password.new(user[:password]) == params[:password]
        session[:username] = user[:username]
        session[:user_id] = user[:player_id]
        redirect '/'
      end
    end
    slim :'main/error_login'
  end

  get '/signout' do
    session[:username] = nil
    redirect '/'
  end

  def validate(password,length_req)
    not_empty = Validator.not_empty? password
    longer_than = Validator.longer_than?(length_req,password)

    return not_empty unless not_empty[:result]
    return longer_than unless longer_than[:result]
    {result: true}
  end
end