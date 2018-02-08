require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists(name) VALUES ($1) RETURNING id"
    values = [@name]
    artists = SqlRunner.run(sql, values)
    @id = artists[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{ |person| Artist.new(person)}
  end

  def albums_return()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    album_details = SqlRunner.run(sql,values)
    result = album_details.map{|disk| Album.new(disk)}
    return result
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@id,@name]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find()
    sql = "SELECT * FROM artists WHERE id = #{id}"
    values = [@id]
    result = SqlRunner.run(sql,values)
    artist_hash = result.first
    Artish.new(artist_hash)
    # return artish
  end

end
