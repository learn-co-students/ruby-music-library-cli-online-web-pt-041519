class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
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
    input = gets.strip
    until input == "exit"
      if input == "list songs"
        list_songs
        input = gets.strip
      elsif input == "list artists"
        list_artists
        input = gets.strip
      elsif input == "list genres"
        list_genres
        input = gets.strip
      elsif input == "list artist"
        list_songs_by_artist
        input = gets.strip
      elsif input == "list genre"
        list_songs_by_genre
        input = gets.strip
      elsif input == "play song"
        play_song
        input = gets.strip
      else
        input = gets.strip
      end
    end
  end
  
  def list_songs
    list = Song.all.sort_by {|song| song.name}
    list.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    list = Artist.all.sort_by {|artist| artist.name}
    list.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end
  
  def list_genres
    list = Genre.all.sort_by {|genre| genre.name}
    list.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    list = Song.all.select {|song| song.artist.name == input}.sort_by {|song| song.name}
    list.each_with_index do |song, i|
      puts "#{i + 1}. #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    list = Song.all.select {|song| song.genre.name == input}.sort_by {|song| song.name}
    list.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name}"
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    list = Song.all.sort_by {|song| song.name}
    puts "Playing #{list[input - 1].name} by #{list[input - 1].artist.name}" unless input < 1 || input > list.size
  end

end