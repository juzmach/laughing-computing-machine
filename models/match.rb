class Match < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM match').all
  end

  def self.find_by_id(match_id)
    DB.fetch('SELECT * FROM match WHERE match_id = ?',match_id).first
  end

  def self.all_with_player_data
    DB.fetch('SELECT *
              FROM match
              INNER JOIN team
                ON team.team_id = match.team_a_id OR team.team_id = match.team_b_id
              INNER JOIN player
                ON player.player_id = team.player_one_id OR player.player_id = team.player_two_id').all
  end

  def self.latest_matches
    DB.fetch('SELECT *
              FROM match
              INNER JOIN team
                ON team.team_id = match.team_a_id OR team.team_id = match.team_b_id
              INNER JOIN player
                ON player.player_id = team.player_one_id OR player.player_id = team.player_two_id
              ORDER BY match.created_at DESC
              LIMIT 5').all
  end

  def self.players_matches(player_id)
    DB.fetch('SELECT * FROM match WHERE team_a_id = ? or team_b_id = ?',player_id,player_id).all
  end

  def self.create (tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status)
    is_tournament_match = false
    unless tournament_id.nil?
      is_tournament_match = true
    end
    sql_query = 'INSERT INTO match (is_tournament_match,tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status)
                  VALUES (?,?,?,?,?,?,?)'
    insert_ds = DB[sql_query,is_tournament_match,tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status]
    insert_ds.insert
  end

  def self.update(match_id,team_a_id,team_b_id,team_a_score,team_b_score,match_date,status)
    sql_query = 'UPDATE match SET team_a_id = ?, team_b_id = ?,team_a_score = ?,team_b_score = ?, match_date = ?, status = ? WHERE match_id = ?'
    update_ds = DB[sql_query,team_a_id,team_b_id,team_a_score,team_b_score,match_date,status,match_id]
    update_ds.update
  end

  def self.end_match(match_id,team_a_score,team_b_score)
    sql_query = 'UPDATE match SET team_a_score = ?, team_b_score = ?, status = ? where match_id = ?'
    update_ds = DB[sql_query,team_a_score,team_b_score,'Completed',match_id]
    update_ds.update

  end

  def self.destroy(match_id)
    sql_query = 'DELETE FROM match WHERE match_id = ?'
    delete_ds = DB[sql_query,match_id]
    delete_ds.delete
  end

end