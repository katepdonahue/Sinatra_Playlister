require 'bundler'
Bundler.require

require "./lib/artist"
require "./lib/song"
require "./lib/genre"
require "./lib/parser"


class App < Sinatra::Application
  before do
    library = Parser.new
    library.parse
  end

  get '/' do
    erb :index
  end

  get '/:input' do |input|
    
    case input
    when "songs"
      @output = Song.all
      @item = "songs"
    when "artists"
      @output = Artist.all
      @item = "artists"
    when "genres"
      @output = Genre.all.sort_by {|genre| genre.songs.count}.reverse
      @item = "genres"
    else
      erb :error_page
    end
    erb :page
  end

  get '/artists/:input' do |input|
    @artist = Artist.find_by_name(input.downcase)
    @artist.songs.size > 1 ? @s = "songs" : @s = "song"
    @song_array = []
    @artist.songs.each_with_index do |song, index|
      @song_array << "#{song.name} - #{song.genre.name}"
    end
    erb :artist_page

  end
 
end



