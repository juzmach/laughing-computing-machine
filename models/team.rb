class Team < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM team').all
  end

  def self.find_by_id(team_id)
    DB.fetch('SELECT * FROM team WHERE team_id = ?',team_id).first
  end

  def self.find_by_player_id(player_id)
    DB.fetch('SELECT * FROM team WHERE player_one_id = ? or player_two_id = ?',player_id,player_id).first
  end

  def self.contains_player?(team_id,player_id)
    team = self.find_by_id team_id
    if player_id == team[:player_one_id] or player_id == team[:player_two_id]
      return true
    else
      return false
    end
  end

  def self.create(team_name,player_one_id,player_two_id)
    sql_query = 'INSERT INTO team (team_name,player_one_id,player_two_id) VALUES (?,?,?)'
    insert_ds = DB[sql_query,team_name,player_one_id,player_two_id]
    insert_ds.insert
    return DB.fetch('SELECT * FROM team WHERE player_one_id = ? ORDER BY created_at DESC LIMIT 1',
                    player_one_id).first
  end

  def self.update(team_id,team_name,player_one_id,player_two_id)
    sql_query = 'UPDATE team SET team_name = ?, player_one_id = ?, player_two_id = ? WHERE team_id = ?'
    update_ds = DB[sql_query,team_name,player_one_id,player_two_id,team_id]
    update_ds.update
  end

  def self.update_player_stats(team_a_id,team_b_id,team_a_result,team_b_result,score_modifier)
    team_a = Team.find_by_id(team_a_id)
    team_b = Team.find_by_id(team_b_id)

    Player.update_stats(team_a[:player_one_id],team_b[:player_one_id],team_a_result,score_modifier)
    Player.update_stats(team_b[:player_one_id],team_a[:player_one_id],team_b_result,score_modifier)
    unless team_a[:player_two_id].nil? and team_b[:player_two_id].nil?
      Player.update_stats(team_a[:player_two_id],team_b[:player_one_id],team_a_result,score_modifier)
      Player.update_stats(team_b[:player_two_id],team_a[:player_one_id],team_b_result,score_modifier)
    end

  end

  def self.destroy(team_id)
    sql_query = 'DELETE FROM team WHERE team_id = ?'
    delete_ds = DB[sql_query,team_id]
    delete_ds.delete
  end

end