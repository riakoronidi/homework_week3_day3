require('pg')
require_relative("./artist")
require_relative('../db/sql_runner.rb')

class Album

  attr_accessor :name, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end


  def save()
    sql = "INSERT INTO albums(name,genre,artist_id) VALUES ($1,$2,$3) RETURNING id"
    values = [@name, @genre, @artist_id]
    albums = SqlRunner.run(sql, values)
    @id = albums[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{ |disk| Album.new(disk)}
  end

  def artist_return()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist_details = SqlRunner.run(sql, values)
    result = Artist.new(artist_details[0])
    return result
  end

  def update()
    sql = "UPDATE albums SET (name,genre) = ($1,$2) WHERE id = $3"
    values = [@name, @genre, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = #{id}"
    values = [id]
    result = SqlRunner.run(sql,values)
    album_hash = result.first
    Album.new(album_hash)
    # return album
  end

end
