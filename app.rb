require 'bundler'
Bundler.require

require "./lib/artist"
require "./lib/song"
require "./lib/genre"
require "./lib/parser"


class App < Sinatra::Application

  get '/' do
    erb :index
  end

  get '/:input' do |input|
    library = Parser.new
    library.parse
    case input
    when "song"
      @output = Song.song_list
      @item = "songs"
    when "artist"
      @output = Artist.index
      @item = "artists"
    when "genre"
      @output = Genre.sort_by_songs
      @item = "genres"
    else
      erb :error_page
    end
    erb :page
  end
 
end



