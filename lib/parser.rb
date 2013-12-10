require './artist'
require './song'
require './genre'

class Parser
  attr_accessor :data

  def objects(artist_name, song_name, genre_name)
    song = Song.new.tap{|s| s.name = song_name}
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
  end

  def parse
    songs = Dir.entries("../data").select {|f| !File.directory? f}
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


# require './artist'
# require './song'
# require './genre'
# # require 'debugger'

# def artist(data)
#   artist_array = []
#   songs = Dir.entries(data).select {|f| !File.directory? f}
#   songs.each do |filename|
#     regex = /(.*)\s-\s/
#     m = regex.match(filename)
#     artist_array << m[1]  
#   end
#   artist_array
# end

# def song(data)
#   song_array = []
#   songs = Dir.entries(data).select {|f| !File.directory? f}
#   songs.each do |filename|
#     regex = /\s-\s(.*)\s/
#     m = regex.match(filename)
#     song_array << m[1]
#   end
#   song_array
# end

# def genre(data)
#   genre_array = []
#   songs = Dir.entries(data).select {|f| !File.directory? f}
#   songs.each do |filename|
#     regex = /\[(.+)\]/
#     m = regex.match(filename)
#     genre_array << m[1]
#   end
#   genre_array
# end

# puts genre("../data")
# puts song("../data")
# puts artist("../data")