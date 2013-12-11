class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.count
   @@all.size
  end

  def self.reset_all
     @@all = []
  end

  def genre=(genre)
    @genre = genre 
    genre.songs << self
  end

  def artist=(artist)
    @artist = artist
    artist.songs << self
  end

  def self.find_by_name(string)
    @@all.detect{|a| a.name == string}
  end

  def format
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
  end

  def url
    self.name.downcase.gsub(' ','-')
  end

end