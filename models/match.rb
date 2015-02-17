class Match < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM matches').all
  end

  def self.find_by_id(id)
    DB.fetch('SELECT * FROM matches WHERE id = ?',id).first
  end

  def self.all_with_player_data
    DB.fetch('SELECT *
              FROM matches
              INNER JOIN teams
                ON teams.id = matches.team_a_id OR teams.id = matches.team_b_id
              INNER JOIN players
                ON players.id = teams.player_one_id OR players.id = teams.player_two_id').all
  end

  def self.latest_matches
    DB.fetch('SELECT *
              FROM matches
              INNER JOIN teams
                ON teams.id = matches.team_a_id OR teams.id = matches.team_b_id
              INNER JOIN players
                ON players.id = teams.player_one_id OR players.id = teams.player_two_id
              ORDER BY matches.created_at DESC
              LIMIT 5').all
  end

  def self.players_matches(player_id)
    DB.fetch('SELECT * FROM matches WHERE team_a_id = ? or team_b_id = ?',player_id,player_id).all
  end

  def self.create (tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status)
    is_tournament_match = false
    unless tournament_id.nil?
      is_tournament_match = true
    end
    sql_query = 'INSERT INTO matches (is_tournament_match,tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status)
                  VALUES (?,?,?,?,?,?,?)'
    insert_ds = DB[sql_query,is_tournament_match,tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status]
    insert_ds.insert
  end

  def self.update(id,team_a_id,team_b_id,team_a_score,team_b_score,match_date,status)
    sql_query = 'UPDATE matches SET team_a_id = ?, team_b_id = ?,team_a_score = ?,team_b_score = ?, match_date = ?, status = ? WHERE id = ?'
    update_ds = DB[sql_query,team_a_id,team_b_id,team_a_score,team_b_score,match_date,status,id]
    update_ds.update
  end

  def self.destroy(id)
    sql_query = 'DELETE FROM matches WHERE id = ?'
    delete_ds = DB[sql_query,id]
    delete_ds.delete
  end

end