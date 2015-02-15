require 'sequel'

DB = Sequel.connect adapter: 'postgres', host: ENV['DBHOST'], database: ENV['DBNAME'], user: ENV['DBUSER'], password: ENV['DBPASSWD']
DB << "SET CLIENT_ENCODING TO 'UTF-8';"

require_relative 'validator'
require_relative 'player'
require_relative 'tournament'
require_relative 'team'
require_relative 'match'