class Artist

  attr_accessor :name, :songs
  @@artists = []

  def initialize
    @songs = []
    @@artists << self
  end

  def add_song(song)
    @songs << song
    song.genre.artists << self if song.genre && song.genre.artists.include?(self) == false
    song.artist = self
  end

  def self.reset_artists
    @@artists.clear
  end

  def songs_count
    songs.size
  end

  def self.count
   @@artists.size
  end

  def self.all
    @@artists
  end

  def genres
    @songs.collect{|s| s.genre}.uniq
  end

  def self.find_or_create_by_name(string)
   find_by_name(string) || Artist.new.tap{|g| g.name = string}
  end

  def self.find_by_name(string)
    @@artists.detect{|a| a.name.downcase.gsub(".", "") == string.downcase}
  end

  def url
    name.downcase.gsub(' ','-')
  end

  def format
    self.songs.size > 1 ? s = "songs" : s = "song"
    "#{self.name} - #{self.songs.size} #{s.capitalize}"
  end
end