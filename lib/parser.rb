class Parser
  attr_accessor :data

  def objects(artist_name, song_name, genre_name)
    song = Song.new.tap{|s| s.name = song_name}
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
  end

  def parse
    songs = Dir.entries("./public/data").select {|f| !File.directory? f}
    songs.each do |filename|
      artist_name = /(.*)\s-\s/.match(filename)
      artist_name = artist_name[1]
      song_name = /\s-\s(.*)\s/.match(filename)
      song_name = song_name[1]
      genre_name = /\[(.+)\]/.match(filename)
      genre_name = genre_name[1]
      objects(artist_name, song_name, genre_name)
    end
  end
end