# encoding: utf-8

class Player < Sequel::Model
  def self.all
    with_sql('SELECT * FROM players').all
  end
end