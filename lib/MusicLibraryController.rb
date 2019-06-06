
class MusicLibraryController
  attr_reader :alphabetized_list

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    user_input = " "

    while user_input != "exit"
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
    # case user_input

    if "list songs" === user_input
      list_songs
    elsif "list artists" === user_input
      list_artists
    elsif "list genres" === user_input
      list_genres
    elsif "list artist" === user_input
      list_songs_by_artist
    elsif "list genre" === user_input
      list_songs_by_genre
    elsif "play song" === user_input
      play_song
    else
    end

  end
  end

  def list_songs
    # binding.pry
    alphabetized_list = Song.all.sort_by{|song| song.name}.each_with_index {|song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
    alphabetized_list.map.with_index{|song, index| "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    # binding.pry
    alphabetized_list = Artist.all.sort_by{|artist| artist.name}.uniq
    #
    # .each_with_index {|song, index|
    #   puts "#{index+1}. #{song.artist.name}"
    # }
    # binding.pry
    alphabetized_list.map.with_index{|artist, index| puts "#{index+1}. #{artist.name}"}

  end

  def list_genres
    genres = Genre.all.sort_by{|genre| genre.name}.uniq
    genres.map.with_index{|genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    a_list = Artist.all.map do |artist|
      if artist.name == user_input
        a_songs = artist.songs
        a_songs_sorted = a_songs.sort_by{|song| song.name}
        a_songs_sorted.map.with_index do |song, index|
          puts "#{index+1}. #{song.name} - #{song.genre.name}"
         end
       end
     end

     def list_songs_by_genre
       puts "Please enter the name of a genre:"
       user_input = gets.strip
       g_list = Genre.all.map do |genre|
         if genre.name == user_input
           g_songs = genre.songs
            g_songs_sorted = g_songs.sort_by{|song| song.name}
            g_songs_sorted.map.with_index do |song, index|
             puts "#{index+1}. #{song.artist.name} - #{song.name}"
           end
          end
        end
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      user_input = gets.strip.to_i
      if (1..Song.all.length).include?(user_input)
        song = Song.all.sort{|a,b| a.name <=> b.name}[user_input-1]
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end
