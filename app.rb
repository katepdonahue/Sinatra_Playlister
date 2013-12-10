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
  
end