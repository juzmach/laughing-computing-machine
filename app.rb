# encoding: utf-8
require 'sinatra'
require 'slim'

class Ranking < Sinatra::Application
  enable :sessions

  helpers do

    def login?
      return session[:username].nil?
    end

    def username
      return session[:username]
    end

  end

end

require_relative 'models/init'
require_relative 'controllers/init'
