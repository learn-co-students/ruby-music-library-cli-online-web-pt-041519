require 'pry'
class MusicLibraryController
  attr_accessor :path
  def initialize(path = './db/mp3s')
    music = MusicImporter.new(path)
    music.import
    #binding.pry
  end 
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.chomp
    case user_input
		when 'list songs'
			list_songs

		when 'list artists'
			list_artists

		when 'list genres'
			list_genres

		when 'list artist'
			list_songs_by_artist

		when 'list genre'
			list_songs_by_genre

		when 'play song'
			play_song

		when 'exit'
			return

		else
		call
		end
  end 
  
  def list_songs 
    Song.all.sort{|a, b| a.name <=> b.name }.each.with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end 
  
  def list_artists
    Artist.all.sort{|a, b| a.name <=> b.name }.each.with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end
  
  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name }.each.with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_artist = gets.chomp
    if artist_object = Artist.find_by_name(user_artist)
      artist_object.songs.sort{|a, b| a.name <=> b.name }.each.with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end 
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_genre = gets.chomp
    if genre_object = Genre.find_by_name(user_genre)
      genre_object.songs.sort{|a, b| a.name <=> b.name }.each.with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end 
    end
  end
  
  def play_song
    #list_songs
    puts "Which song number would you like to play?"
    #list_songs
    user_song = gets.strip.to_i
    if user_song > 0 && user_song <= Song.all.length
      sorted_array = Song.all.sort{|a,b| a.name <=> b.name}
      selection = sorted_array[user_song-1]
      #song = Song.all.sort{|a,b| a.name <=> b.name}[user_song-1]
      puts "Playing #{selection.name} by #{selection.artist.name}"
    end
    
  end 
end #end class

#binding.pry