# encoding: utf-8
require 'sinatra'
require 'slim'

class Ranking < Sinatra::Application
  enable :sessions
  set :sessions_secret, "TS0h42015"
  set :root, File.dirname(__FILE__)
  helpers do

    def authenticated?
      if session[:username].nil?
        return false
      else
        return true
      end
    end

    def username
      return session[:username]
    end

  end

end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'controllers/init'
