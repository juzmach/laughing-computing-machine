#encoding: utf-8
require 'bcrypt'

# Main Controller
class Ranking < Sinatra::Application
  get '/' do
    slim :index
  end

  get '/register' do
    slim :register
  end

  post '/register' do
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    Player.create params[:username],password_salt,password_hash, params[:name]
    redirect '/'
  end

  post '/signin' do

  end
end