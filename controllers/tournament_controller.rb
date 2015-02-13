#encoding: utf-8

class Ranking < Sinatra::Application
  get '/tournaments' do
    slim :'tournaments/tournaments'
  end

  get '/tournaments/new' do
    slim :'tournaments/add_tournament'
  end
end