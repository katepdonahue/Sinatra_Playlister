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
    @@all.detect{|a| a.name.downcase.gsub(".", "") == string.downcase}
  end

  def format
    "#{self.name} - #{self.artist.name} (#{self.genre.name})"
  end

  def url
    self.name.downcase.gsub(' ','-')
  end

  def url_format
    self.name.gsub(" ", "%20").gsub(".", "").downcase
  end
end