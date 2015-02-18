# encoding: utf-8

class Player < Sequel::Model
  def self.all
    DB.fetch('SELECT * FROM player').all
  end

  def self.top10
    DB.fetch('SELECT * FROM player ORDER BY ranking_score DESC LIMIT 10').all
  end

  def self.find_by_id (player_id)
    DB.fetch('SELECT * FROM player WHERE player_id = ?',player_id).first
  end

  def self.find_by_username (username)
    DB.fetch('SELECT * FROM player WHERE username LIKE ? LIMIT 1',username).first
  end

  def self.create (username,password, player_name)
    sql_query = 'INSERT INTO player (username,password,player_name) VALUES (?,?,?)'
    insert_ds = DB[sql_query,username,password,player_name]
    insert_ds.insert
  end

  def self.update(player_id, new_password,player_name)
    sql_query = 'UPDATE player SET password = ?, player_name = ? WHERE player_id = ?'
    update_ds = DB[sql_query,new_password,player_name,player_id]
    update_ds.update
  end

  def self.update_stats(player_id,opponent_id,result,score_modifier)
    player = self.find_by_id(player_id)
    opponent = self.find_by_id(opponent_id)

    stats = 'ranking_score = ?'

    if result == 2
      stats << ', wins = wins + 1'
    elsif result == 1
      stats << ', ties = ties + 1'
    else
      stats << ', losses = losses + 1'
    end

    sql_query = "UPDATE player SET #{stats} WHERE player_id = ?"
    update_ds = DB[sql_query,RankingCalculator.calculate(score_modifier,result,player[:ranking_score],opponent[:ranking_score]),player_id]
    update_ds.update
  end

  def self.destroy(player_id)
    sql_query = 'DELETE FROM player WHERE player_id = ?'
    delete_ds = DB[sql_query,player_id]
    delete_ds.delete
  end
end