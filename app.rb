require 'bundler'
Bundler.require

require "./lib/artist"
require "./lib/song"
require "./lib/genre"
require "./lib/parser"
require "./lib/scraper"


class App < Sinatra::Application
  library = Parser.new
  library.parse

  get '/' do
    erb :index
  end

  get '/:input' do |input|
    
    case input
    when "songs"
      @output = Song.all.sort_by {|song| song.name}
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
    @artist = Artist.find_by_name(input)
    @artist.songs.size > 1 ? @s = "songs" : @s = "song"
    erb :artist_page
  end

  get '/songs/:input' do |input|
    @song = Song.find_by_name(input)
    my_scraper = Video_Scraper.new(@song.artist.url_format, @song.url_format)
    url = my_scraper.video # scraped url from youtube API
    match_obj = /.*v\/(.*)\?.*/.match(url)
    @video = match_obj[1]
    erb :song_page
  end

  get '/genres/:input' do |input|
    @genre = Genre.find_by_name(input)
    @genre.songs.size > 1 ? @s = "songs" : @s = "song"
    erb :genre_page
  end
 
end



