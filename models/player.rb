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

  def self.create (username,password, player_name)
    sql_query = 'INSERT INTO players (username,password,player_name) VALUES (?,?,?)'
    insert_ds = DB[sql_query,username,password,player_name]
    insert_ds.insert
  end

  def self.update(id, new_password,player_name)
    sql_query = 'UPDATE players SET password = ?, player_name = ? WHERE id = ?'
    update_ds = DB[sql_query,new_password,player_name,id]
    update_ds.update
  end

  def self.destroy(id)
    sql_query = 'DELETE FROM players WHERE id = ?'
    delete_ds = DB[sql_query,id]
    delete_ds.delete
  end
end