class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    user_input = ""
    until user_input == 'exit'
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.strip

      if user_input == 'list songs'
        self.list_songs
      elsif user_input == 'list artists'
        self.list_artists
      elsif user_input == 'list genres'
        self.list_genres
      elsif user_input == 'list artist'
        self.list_songs_by_artist
      elsif user_input == 'list genre'
        self.list_songs_by_genre
      elsif user_input == 'play song'
        self.play_song
      end
    end
  end

  def list_songs
    Song.all.sort_by(&:name).each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
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

     artist_name = gets.strip
     artist = Artist.find_by_name(artist_name)

     if artist
       songs = artist.songs.sort_by(&:name)
       songs.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
     end
   end

  def list_songs_by_genre
     puts "Please enter the name of a genre:"
     genre_name = gets.strip
     genre = Genre.find_by_name(genre_name)

     if genre
       songs = genre.songs.sort_by(&:name)
       songs.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
     puts "Which song number would you like to play?"
     song_number = gets.strip.to_i

     if (1..Song.all.length).include?(song_number)
        song_name = Song.all.sort_by(&:name)[song_number - 1].name
        artist_name = Song.all.sort_by(&:name)[song_number - 1].artist.name
        puts "Playing #{song_name} by #{artist_name}"
     end
   end

end
