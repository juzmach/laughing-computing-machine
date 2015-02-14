class Tournament < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM tournaments').all
  end

  def self.latest_tournaments
    DB.fetch('SELECT * FROM tournaments ORDER BY start_date DESC LIMIT 5').all
  end

  def self.find_by_id(id)
    DB.fetch('SELECT * FROM tournaments WHERE ID = ? LIMIT 1',id).first
  end

  def self.create(name,start_date,start_time,end_date,end_time,location,admin_id)
    sql_query = 'INSERT INTO tournaments (name,start_date,start_time,end_date,end_time,location,admin_id) VALUES (?,?,?,?,?,?,?)'
    insert_ds = DB[sql_query,
                   name,
                   start_date,
                   start_time,
                   end_date,
                   end_time,
                   location,
                   admin_id]
    insert_ds.insert
  end

  def self.update(id,name,start_date,start_time,end_date,end_time,location,admin_id)
    sql_query = 'UPDATE tournaments SET name = ?, start_date = ?, start_time = ?, end_date = ?, end_time = ?, location = ?, admin_id = ? WHERE id = ?'
    update_ds = DB[sql_query,
                   name,
                   start_date,
                   start_time,
                   end_date,
                   end_time,
                   location,
                   admin_id,
                   id]
    update_ds.update
  end

  def self.destroy(id)
    sql_query = 'DELETE FROM tournaments WHERE id = ?'
    delete_ds = DB[sql_query,id]
    delete_ds.delete
  end
end