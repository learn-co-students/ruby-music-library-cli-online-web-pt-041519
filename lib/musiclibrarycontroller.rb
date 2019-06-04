require 'pry'
class MusicLibraryController
  
  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end
  
  def call
    input = ""
    
    while input != "exit" 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'." 
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp
    
    case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end
  
  def list_songs
  Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
    puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end
end
  
  def list_artists
    Artist.all.sort_by(&:name).each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
      end
    end
    
  def list_genres
    Genre.all.sort_by(&:name).each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
      end
    end
    
  def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.chomp
    
      if artist_list = Artist.find_by_name(input)
        artist_list.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
      #binding.pry
    end
  end
  
  def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.chomp
    
      if genre_list = Genre.find_by_name(input)
        genre_list.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    input = input - 1
      if input < Song.all.length && input > 0
        song = Song.all.sort_by!{|song| song.name}
        puts "Playing #{song[input].name} by #{song[input].artist.name}"
      else
      end
      #binding.pry
    end
    
  
end


