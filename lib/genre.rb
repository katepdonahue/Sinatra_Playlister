class Genre
  
  attr_accessor :name, :songs
  @@all = []

  def initialize
    @songs = []
    @@all << self
  end

  # def add_song(song)
  #   @songs << song
  #   song.artist = self
  # end

  def self.count
   @@all.size
  end

  def self.all
    @@all
  end

  # def self.reset_all
  #    @@all = []
  # end

  def self.reset_genres
    @@all.clear
  end

  def artists
    @songs.collect{|s| s.artist}.uniq
  end

  def self.find_or_create_by_name(string)
    find_by_name(string) || Genre.new.tap{|g| g.name = string}
  end

  def self.find_by_name(string)
    @@all.detect{|a| a.name == string}
  end

  def url
    name.downcase.gsub(' ','-')
  end

 #sort on qty of songs in a genre
  def format
    self.songs.size > 1 ? s = "songs" : s = "song"
    "#{self.name.capitalize}: #{self.songs.size} #{s.capitalize}, #{self.artists.size} Artists"
  end
end