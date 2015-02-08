#encoding: utf-8
require 'bcrypt'

# Main Controller
class Ranking < Sinatra::Application
  get '/' do
    @players_top10 = Player.top10
    slim :index
  end

  get '/register' do
    slim :register
  end

  post '/register' do
    password = BCrypt::Password.create(params[:password])
    Player.create params[:username],password, params[:name]
    redirect '/'
  end

  post '/signin' do
    user = Player.find_by_username(params[:username])
    unless user.nil?
      if BCrypt::Password.new(user[:password]) == params[:password]
        session[:username] = user[:username]
        session[:user_id] = user[:id]
        redirect '/'
      end
    end
    slim :error_login
  end

  get '/signout' do
    session[:username] = nil
    redirect '/'
  end
end