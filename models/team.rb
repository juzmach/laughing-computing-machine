class Team < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM teams').all
  end

  def self.find_by_id(id)
    DB.fetch('SELECT * FROM teams WHERE id = ?',id)
  end

  def self.find_by_player_id(id)
    DB.fetch('SELECT * FROM teams WHERE player_one_id = ? or player_two_id = ?',id,id).first
  end

  def self.create(team_name,player_one_id,player_two_id)
    sql_query = 'INSERT INTO teams (team_name,player_one_id,player_two_id) VALUES (?,?,?)'
    insert_ds = DB[sql_query,team_name,player_one_id,player_two_id]
    insert_ds.insert
  end

  def self.update(id,team_name,player_one_id,player_two_id)
    sql_query = 'UPDATE teams SET team_name = ?, player_one_id = ?, player_two_id = ? WHERE id = ?'
    update_ds = DB[sql_query,team_name,player_one_id,player_two_id,id]
    update_ds.update
  end

  def self.destroy(id)
    sql_query = 'DELETE FROM teams WHERE id = ?'
    delete_ds = DB[sql_query,id]
    delete_ds.delete
  end

end