##
# This class represents Match and contains all the database transaction code related to it.
# encoding: utf-8

class Match < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM match ORDER BY updated_at DESC').all
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
    DB.fetch("SELECT * FROM match WHERE status LIKE 'Completed' ORDER BY updated_at DESC LIMIT 5").all
  end

  def self.players_matches(player_id)
    DB.fetch('SELECT a.team_name as team_a_name,
                      b.team_name as team_b_name,
                      a.player_one_id as team_a_player_one,
                      a.player_two_id as team_a_player_two,
                      b.player_one_id as team_b_player_one,
                      b.player_two_id as team_b_player_two,
                      team_a_score,
                      team_b_score,
                      match_date,
                      status
                FROM match
                JOIN team a ON match.team_a_id = a.team_id
                JOIN team b ON match.team_b_id = b.team_id
                WHERE a.player_one_id = ? OR
                      a.player_two_id = ? OR
                      b.player_one_id = ? OR
                      b.player_two_id = ?',player_id,player_id,player_id,player_id).all
  end

  def self.create (tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status)
    sql_query = 'INSERT INTO match (tournament_id,score_multiplier,team_a_id,team_b_id,match_date)
                  VALUES (?,?,?,?,?)'
    insert_ds = DB[sql_query,tournament_id,score_multiplier,team_a_id,team_b_id,match_date]

    unless status.nil?
      sql_query = 'INSERT INTO match (tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status)
                  VALUES (?,?,?,?,?,?)'
      insert_ds = DB[sql_query,tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status]
    end

    insert_ds.insert
  end

  def self.update(match_id,match_date,status)
    sql_query = 'UPDATE match SET
                  match_date = ?,
                  status = ?,
                  updated_at = current_timestamp
                  WHERE match_id = ?'
    update_ds = DB[sql_query,match_date,status,match_id]
    update_ds.update
  end

  def self.confirm(match_id)
    sql_query = 'UPDATE match SET status = ? WHERE match_id = ?'
    update_ds = DB[sql_query,'Confirmed',match_id]
    update_ds.update
  end

  def self.end_match(match_id,team_a_score,team_b_score)
    sql_query = 'UPDATE match SET team_a_score = ?, team_b_score = ?, status = ? where match_id = ?'
    update_ds = DB[sql_query,team_a_score,team_b_score,'Completed',match_id]
    update_ds.update

    match = Match.find_by_id(match_id)
    team_a_result = 0
    team_b_result = 0

    if match[:team_a_score] < match[:team_b_score]
      team_b_result = 2
    elsif match[:team_a_score] > match[:team_b_score]
      team_a_result = 2
    else
      team_a_result = 1
      team_b_result = 1
    end

    Team.update_player_stats(match[:team_a_id],match[:team_b_id],team_a_result,team_b_result,match[:score_multiplier])
  end

  def self.destroy(match_id)
    sql_query = 'DELETE FROM match WHERE match_id = ?'
    delete_ds = DB[sql_query,match_id]
    delete_ds.delete
  end

end