class MusicLibraryController
  
  attr_accessor :music_importer
  
  def initialize(path = "./db/mp3s") 
    @music = MusicImporter.new(path).import
      # returns array of ["artist - song - genre.mp3", "artist - song...."]
    # @music.each {|file| file.chomp!(".mp3")}
      #removes the .mp3 from the genres to make the array easier to work with
  end 
  
  def call 
    user_input = nil
    until user_input == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets
      
      case user_input 
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
    Song.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |song, index| 
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end 
  end 
  
  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |artist, index| 
      puts "#{index}. #{artist.name}" 
    end 
  end 
  
  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |genre, index| 
      puts "#{index}. #{genre.name}" 
    end 
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets 
    artist_songs = Song.all.select {|song| song.artist.name == user_input}
    artist_songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
      puts "#{index}. #{song.name} - #{song.genre.name}" 
    end 
  end 
    
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    user_input = gets 
    genre_songs = Song.all.select {|song| song.genre.name == user_input} 
    genre_songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name}" 
    end 
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    user_input = gets 
    Song.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
      puts "Playing #{song.name} by #{song.artist.name}" if user_input.to_i == index 
    end 
  end 
  
  

  
end 






