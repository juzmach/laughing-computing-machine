class Tournament < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM tournament').all
  end

  def self.latest_tournaments
    DB.fetch('SELECT * FROM tournament ORDER BY start_date DESC LIMIT 5').all
  end

  def self.find_by_id(tournament_id)
    DB.fetch('SELECT * FROM tournament WHERE tournament_id = ? LIMIT 1',tournament_id).first
  end

  def self.create(tournament_name,start_date,start_time,end_date,end_time,location,admin_id)
    sql_query = 'INSERT INTO tournament (tournament_name,start_date,start_time,end_date,end_time,location,admin_id) VALUES (?,?,?,?,?,?,?)'
    insert_ds = DB[sql_query,
                   tournament_name,
                   start_date,
                   start_time,
                   end_date,
                   end_time,
                   location,
                   admin_id]
    insert_ds.insert
  end

  def self.update(tournament_id,tournament_name,start_date,start_time,end_date,end_time,location,admin_id)
    sql_query = 'UPDATE tournament SET tournament_name = ?, start_date = ?, start_time = ?, end_date = ?, end_time = ?, location = ?, admin_id = ? WHERE tournament_id = ?'
    update_ds = DB[sql_query,
                   tournament_name,
                   start_date,
                   start_time,
                   end_date,
                   end_time,
                   location,
                   admin_id,
                   tournament_id]
    update_ds.update
  end

  def self.destroy(tournament_id)
    sql_query = 'DELETE FROM tournament WHERE tournament_id = ?'
    delete_ds = DB[sql_query,tournament_id]
    delete_ds.delete
  end
end