class MusicLibraryController
  
  attr_accessor :importer
  
  def initialize(file_path = './db/mp3s')
    @importer = MusicImporter.new(file_path).import
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
      
      input = nil
      
      until input == "exit"
        input = gets.chomp
        case input
        when "list songs" then list_songs
        when "list artists" then list_artists
        when "list genres" then list_genres
        when "list artist" then list_songs_by_artist
        when "list genre" then list_songs_by_genre
        when "play song" then play_song
        end
      end

    end
    
    def list_songs
    
      
      sorted = Song.all.sort_by {|song| song.name}
      
      sorted.map.with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        song
      end
    end
    
    def list_artists
      
      sorted = Artist.all.sort_by {|artist| artist.name}
      
      sorted.map.with_index do |artist, i|
        puts "#{i+1}. #{artist.name}"
      end
      
    end
    
    def list_genres
      genres = Genre.all.collect do |genre|
        genre
      end
      
      sorted = genres.sort_by {|genre| genre.name}
      
      sorted.map.with_index do |genre, i|
        puts "#{i+1}. #{genre.name}"
      end
    end
    
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      artist_name = gets.chomp
      counter = 0
      
      songs_by_artist = Song.all.select do |song|
        if (song.artist.name == artist_name) 
          song
        end
      end
      
      sorted = songs_by_artist.sort_by {|song| song.name}
      
      sorted.map.with_index do |song, i|
        puts "#{i+1}. #{song.name} - #{song.genre.name}"
      end
    end
    
    
    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      genre_name = gets.chomp
      
      songs_in_genre = Song.all.select do |song|
        if (song.genre.name == genre_name) 
          song
        end
      end
      
      sorted = songs_in_genre.sort_by {|song| song.name}
      
      sorted.map.with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name}"
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      song_number = gets.to_i
      
      sorted = Song.all.sort_by {|song| song.name}

      if song_number.between?(1, sorted.length)
        puts "Playing #{sorted[song_number-1].name} by #{sorted[song_number-1].artist.name}"

      end
    end
  end
  