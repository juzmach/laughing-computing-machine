# encoding: utf-8

class Player < Sequel::Model
  def self.all
    with_sql('SELECT * FROM players').all
  end

  def self.create (username,password_salt,password_hash, name)
    insert_dataset = DB["INSERT INTO players (username,password_salt,password_hash,name) VALUES (?,?,?,?)",username,password_salt,password_hash,name]
    insert_dataset.insert
  end

  def self.find (id)
    with_sql('SELECT * FROM players WHERE id = ?',id).first
  end
end