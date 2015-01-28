require 'sequel'

DB = Sequel.postgres ENV['DBNAME'],user: ENV['DBUSER'],password: ENV['DBPASSWD'], host: ENV['DBHOST']
DB << "SET CLIENT_ENCODING TO 'UTF-8';"

require_relative 'player'
#require_relative 'tournament'
#require_relative 'team'
#require_relative 'match'