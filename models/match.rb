class Match < Sequel::Model

  def self.all
    DB.fetch('SELECT * FROM matches').all
  end

  def self.find_by_id(id)
    DB.fetch('SELECT * FROM matches WHERE id = ?',id).first
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