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
  #   Song.all.sort{|a, b| a.name <=> b.name }.each.with_index do |song, index|
  #   puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  # end
  # libr = self.new
  # binding.pry
   
  end 
  
end #end class