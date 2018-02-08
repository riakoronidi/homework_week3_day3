require("pry")
require_relative("../models/artist.rb")
require_relative("../models/album.rb")


artist1 = Artist.new({'name' => 'Kylie Minogue'})
artist1.save()
artist2 = Artist.new({'name' => 'Travis'})
artist2.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'genre' => 'Dance-Pop',
  'name' => 'Kiss me Once'
  })
album1.save()

album2 = Album.new({
  'artist_id' => artist1.id,
  'genre' => 'Electropop',
  'name' => 'Aphrodite'
  })
album2.save()


album1.artist_return()
artist1.albums_return()


album1.genre = "Rock"
album1.update()


artist2.delete()
album1.delete()

# album1.find()
# artist1.find()

binding.pry
nil
