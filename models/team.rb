class Team < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM team').all
  end

  def self.find_by_id(team_id)
    DB.fetch('SELECT * FROM team WHERE team_id = ?',team_id)
  end

  def self.find_by_player_id(player_id)
    DB.fetch('SELECT * FROM team WHERE player_one_id = ? or player_two_id = ?',player_id,player_id).first
  end

  def self.create(team_name,player_one_id,player_two_id)
    sql_query = 'INSERT INTO team (team_name,player_one_id,player_two_id) VALUES (?,?,?)'
    insert_ds = DB[sql_query,team_name,player_one_id,player_two_id]
    insert_ds.insert
  end

  def self.update(team_id,team_name,player_one_id,player_two_id)
    sql_query = 'UPDATE team SET team_name = ?, player_one_id = ?, player_two_id = ? WHERE team_id = ?'
    update_ds = DB[sql_query,team_name,player_one_id,player_two_id,team_id]
    update_ds.update
  end

  def self.update_player_stats()

  def self.destroy(team_id)
    sql_query = 'DELETE FROM team WHERE team_id = ?'
    delete_ds = DB[sql_query,team_id]
    delete_ds.delete
  end

end