class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
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

          input = gets.strip

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
    Song.all.sort_by { |song| song.name }.each.with_index(1) do |song, i|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  # Helper method: Puts short list of subject with number
    def print_short_list(library)
      library.each.with_index(1) { |obj, index| puts "#{index}. #{obj}" }
    end

  # Puts list of artists in numbered, alphabetical list
  def list_artists
    # Get all artists, remove duplicates, and sort alphabetically
    library = Artist.all.collect { |artist| artist.name}.uniq.sort

    # Puts list with index
    print_short_list(library)
  end

  #Puts list of genres in numbered, alphabetical list
  def list_genres
    # Get all genres, remove duplicates, and sort alphabetically
    library = Genre.all.collect { |genre| genre.name}.uniq.sort

    # Puts list with index
    print_short_list(library)
  end

  # Get artist from user, and puts list of artist's songs if artist exists in library
  def list_songs_by_artist
    # Get artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp

    # Set artist object from input
    artist = Artist.find_by_name(user_input)

    # If artist exists, grab songs and output alphabetized by song name
    if artist != nil
     artist.songs.sort_by { |song| song.name }.each.with_index(1) { |song, index| puts "#{index}. #{song.name} - #{song.genre.name}" }
    end
  end

  # Get genre from user, and puts list of genre's songs if genre exists in library
  def list_songs_by_genre
    # Get artist
    puts "Please enter the name of a genre:"
    user_input = gets.chomp

    #Set genre object from input
    genre = Genre.find_by_name(user_input)

    # If genre exists, grab songs and output alphabetized by song artist name
    if genre != nil
      genre.songs.sort_by { |song| song.name }.each.with_index(1) { |song, index| puts "#{index}. #{song.artist.name} - #{song.name}" }
    end
  end

  # Heper method: Return sorted array of songs by song name
  def sorted_songs
    Song.all.sort_by { |song| song.name }
  end

  # Play song that matches user input
  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp

    # Convert to integer and remove 1 to match array index
    song_number = (user_input.to_i) - 1

    # If input is within library, play song
    if (song_number >= 0) && (song_number < sorted_songs.length) && (sorted_songs[song_number])
      song = sorted_songs[song_number]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
