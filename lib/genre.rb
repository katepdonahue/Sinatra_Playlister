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
  def self.sort_by_songs
    sorted_genres = self.all.sort_by do |genre|
      genre.songs.count
    end
    sorted_genres.reverse.each do |genre|
      genre.songs.size > 1 ? s = "songs" : s = "song"
      puts "#{genre.name.capitalize}: #{genre.songs.size} #{s.capitalize}, #{genre.artists.size} Artists"
    end
    puts "\n"
  end
end