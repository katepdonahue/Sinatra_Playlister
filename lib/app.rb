require './artist'
require './song'
require './genre'
require './parser'


class CLI
  attr_accessor :songs, :selection
  
  def initialize
    @selection
    @songs = Song.all
    @on = true
    call
  end

  def call
    puts "\n"
    puts "Welcome to Playlister"
    puts "\n"
    while @on == true
      self.menu
    end
  end

  def menu
    puts "Please choose from the following options"
    help
    self.command_request
  end

  def command(input)
    case input
      when "library"
        library
      when "artist"
        artist_menu
      when "genre"
        genre_menu
      when "help"
        help
      when "song"
        song_menu
      when "exit"
        puts "\n"
        puts "Good-Bye!"
        puts "\n"
        exit
      when "play"
        play
      else
        "Invalid Choice"
      end
  end

  def help
    puts "\n"
    puts "library -- display all songs available"
    puts "artist  -- artist menu"
    puts "genre   -- genre menu"
    puts "song    -- song menu"
    puts "play    -- gives you the option to play a song by name or index"
    puts "exit    -- exit out of program"
    puts "\n"
  end

  def library
    i = 0
    puts "\n"
    Artist.all.each do |artist, index|
      artist.songs.each do |song|
        puts "#{i + 1}. #{artist.name} - #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
    puts "\nTotal: #{i} songs in the library"
    puts "\n"
  end

  def artist_menu
    puts "\n"
    puts "-- type artist name you're looking for"
    puts "-- type 'list' to display all artist"
    puts "-- type 'menu' to return to main menu"
    puts "-- type 'exit' to exit out of program"
    puts "\n"
    @selection = gets.chomp
    if Artist.find_by_name(@selection)
      artist_page
    elsif @selection == "list"
      Artist.index
    elsif @selection == "menu"
      menu
    elsif @selection == "exit"
      puts "\n"
      puts "Good-Bye!"
      puts "\n"
      exit
    else
      puts "Invalid Choice"
    end 
    artist_menu
  end

  def genre_menu
    puts "\n"
    puts "-- type the genre name you're looking for"
    puts "-- type 'list' to display all genres"
    puts "-- type 'menu' to return to main menu"
    puts "-- type 'exit' to exit out of program"
    puts "\n"
    @selection = gets.chomp
    if Genre.find_by_name(@selection)
      genre_page
    elsif @selection == "list"
      Genre.sort_by_songs
    elsif @selection == "menu"
      menu
    elsif @selection == "exit"
      puts "\n"
      puts "Good-Bye!"
      puts "\n"
      exit
    else
      puts "Invalid Choice"
    end
    genre_menu
  end

  def song_menu
    puts "\n"
    puts "-- search for the song you're looking for"
    puts "-- type 'menu' for main menu"
    puts "-- type 'exit' to exit out of program"
    puts "\n"
    @selection = gets.chomp
    if Song.find_by_name(@selection)
      song_page
    elsif @selection == 'menu'
      menu
    elsif @selection == "exit"
      puts "\n"
      puts "Good-Bye!"
      puts "\n"
      exit
    else
      puts "Invalid Choice"
    end
    song_menu
  end

  def artist_page
    artist = Artist.find_by_name(@selection)
    artist.songs.size > 1 ? s = "songs" : s = "song"
    puts "#{artist.name} - #{artist.songs.count} #{s}"
    artist.songs.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def genre_page
    genre = Genre.find_by_name(@selection)
    puts "Genre: #{genre.name}"
    genre.songs.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name}"
    end
  end

  def song_page
    song = Song.find_by_name(@selection)
    puts "#{song.name} - #{song.artist.name} (#{song.genre.name})"
  end   

  def play
    puts "\n"
    puts "Please enter a song name or number."
    puts "-- type library to view songs and numbers"
    puts "-- type 'menu' for main menu"
    puts "-- type 'exit' to exit out of program"
    puts "\n"
    @selection = gets.chomp.downcase.strip
    result = 0
    if @selection == "library"
      library
    elsif @selection == "menu"
      menu
    elsif @selection == "exit"
      puts "\n"
      puts "Good-Bye!"
      puts "\n"
      exit
    elsif @selection.to_i > 0 && @selection.to_i < Song.all.length + 1
      i = @selection.to_i
      puts "\nNow playing #{Song.all[i-1].name} by #{Song.all[i-1].artist.name}.\n\n"
    elsif @selection.to_i == 0
      Song.all.each do |search|
        if search.name.downcase == @selection
          result = search
        end
      end
      puts "\nNow playing #{result.name} by #{result.artist.name}.\n\n"
    else 
      puts "Invalid Choice"
    end
    play
  end

  def command_request
    self.command(gets.downcase.strip)
  end

end

library = Parser.new
library.parse
CLI.new