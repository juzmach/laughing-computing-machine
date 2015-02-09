# encoding: utf-8

class Player < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM players').all
  end

  def self.top10
    DB.fetch('SELECT * FROM players ORDER BY ranking_score DESC LIMIT 10').all
  end

  def self.find_by_id (id)
    DB.fetch('SELECT * FROM players WHERE id = ?',id).first
  end

  def self.find_by_username (username)
    DB.fetch('SELECT * FROM players WHERE username LIKE ? LIMIT 1',username).first
  end

  def self.create (username,password, name)
    insert_ds = DB['INSERT INTO players (username,password,name) VALUES (?,?,?)',username,password,name]
    insert_ds.insert
  end

  def self.update(id, new_password,name)
    update_ds = DB['UPDATE players SET password = ?, name = ? WHERE id = ?',new_password,name,id]
    update_ds.update
  end

  def self.destroy(id)
    delete_ds = DB['DELETE FROM players WHERE ID = ?',id]
    delete_ds.delete
  end
end