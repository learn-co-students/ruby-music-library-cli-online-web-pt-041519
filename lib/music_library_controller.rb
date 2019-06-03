class MusicLibraryController

    def initialize(path="./db/mp3s")
        @path = path
        stuff = MusicImporter.new(path)
        stuff.import
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
        while true
        thing_the_user_wants_to_do = gets
          
          case thing_the_user_wants_to_do
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
          when "exit"
            exit
          end

        end
    end

    def list_songs
        counter = 0
        Song.all.sort_by(&:name).each do |song|
            counter +=1
            puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        counter = 0
        Artist.all.sort_by(&:name).each do |artist|
            counter +=1
            puts "#{counter}. #{artist.name}"
        end
    end

    def list_genres
        counter = 0
        Genre.all.sort_by(&:name).each do |genre|
            counter +=1
            puts "#{counter}. #{genre.name}"
        end
    end

    def gets
        $stdin.gets
    end

    def list_songs_by_artist

       puts "Please enter the name of an artist:"
       artist_name = gets
       artist = Artist.find_by_name(artist_name)
       return if artist.nil?
       counter = 0
       artist.songs.sort_by(&:name).each do |song|
           counter +=1
           puts "#{counter}. #{song.name} - #{song.genre.name}"
       end

    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets
        genre = Genre.find_by_name(genre_name)
        return if genre.nil?
        counter = 0
        genre.songs.sort_by(&:name).each do |song|
            counter +=1
            puts "#{counter}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        play = gets
        counter = 0
        Song.all.sort_by(&:name).each do |song|
            counter +=1
            if counter == play.to_i
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end
end


