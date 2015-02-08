#encoding: utf-8

class Ranking < Sinatra::Application
  get '/matches' do
    slim :'matches/matches'
  end
end