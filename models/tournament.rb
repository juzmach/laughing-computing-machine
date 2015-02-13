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
    insert_ds = DB['INSERT INTO tournaments (name,start_date,start_time,end_date,end_time,location,admin_id) VALUES (?,?,?,?,?,?,?)',
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
    update_ds = DB['UPDATE tournaments SET name = ?, start_date = ?, start_time = ?, end_date = ?, end_time = ?, location = ?, admin_id = ? WHERE id = ?',
                   name,
                   start_date,
                   start_time,
                   end_date,
                   end_time,
                   location,
                   admin_id]
    update_ds.update
  end

  def self.destroy(id)
    delete_ds = DB[]
    delete_ds.delete
  end
end