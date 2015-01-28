# encoding: utf-8

# Player Controller
class Ranking < Sinatra::Application

  get '/players' do
    slim :players
  end

end