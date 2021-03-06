require('pry')
require_relative('../db/sql_runner')
require_relative('album.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = ([@name])
    results = Sql_runner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  def update()
  sql = "UPDATE artists SET name = $1 WHERE id = $2"
  values = [@name, @id]
  Sql_runner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = Sql_runner.run(sql, values)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
  end

  def self.all
    sql = "SELECT * FROM artists"
    artists = Sql_runner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    artists = Sql_runner.run(sql)
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    artists = Sql_runner.run(sql, values)
  end





#END OF CLASS
end
