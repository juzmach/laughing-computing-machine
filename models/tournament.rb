##
# This class represents Tournament and contains all the database transaction code related to it.
# encoding: utf-8

class Tournament < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM tournament ORDER BY updated_at DESC').all
  end

  def self.latest_tournaments
    DB.fetch('SELECT * FROM tournament ORDER BY start_date DESC LIMIT 5').all
  end

  def self.find_by_id(tournament_id)
    DB.fetch('SELECT * FROM tournament WHERE tournament_id = ? LIMIT 1',tournament_id).first
  end

  def self.tournament_teams(tournament_id)
    DB.fetch('SELECT * FROM team JOIN tournament_team on team.team_id = tournament_team.team_id WHERE tournament_id = ?',tournament_id).all
  end

  def self.join(tournament_id,username,player_id)
    team = Team.create(username,player_id,nil)
    insert_ds = DB['INSERT INTO tournament_team (tournament_id,team_id) VALUES (?,?)',tournament_id,team[:team_id]]
    insert_ds.insert
  end

  def self.leave(tournament_id,player_id)
    team = DB.fetch('SELECT * FROM tournament_team WHERE tournament_id = ? and team_id in (SELECT team_id FROM team WHERE player_one_id = ?)',
                    tournament_id,player_id).first
    sql_query = 'DELETE FROM tournament_team WHERE tournament_team_id = ?'
    delete_ds = DB[sql_query,team[:tournament_team_id]]
    delete_ds.delete
  end

  def self.start(tournament_id)
    sql_query = 'UPDATE tournament SET status = ? WHERE tournament_id = ?'
    update_ds = DB[sql_query,'Started',tournament_id]
    update_ds.update
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