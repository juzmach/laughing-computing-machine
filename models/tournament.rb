class Tournament < Sequel::Model
  def self.all
    with_sql('SELECT * FROM tournaments').all
  end

  def self.create

  end

  def self.find(id)

  end

  def self.update(id)

  end

  def self.destroy(id)

  end
end