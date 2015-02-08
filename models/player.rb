# encoding: utf-8

class Player < Sequel::Model
  def self.all
    with_sql('SELECT * FROM players').all
  end

  def self.create (username,password, name)
    insert_dataset = DB["INSERT INTO players (username,password,name) VALUES (?,?,?)",username,password,name]
    insert_dataset.insert
  end

  def self.find_by_id (id)
    with_sql('SELECT * FROM players WHERE id = ?',id).first
  end

  def self.top10
    with_sql('SELECT * FROM players ORDER BY ranking_score DESC LIMIT 10').all
  end

  def self.find_by_username (username)
    with_sql('SELECT * FROM players WHERE username LIKE ? LIMIT 1',username).first
  end

  def self.update(id)

  end

  def self.destroy(id)

  end
end