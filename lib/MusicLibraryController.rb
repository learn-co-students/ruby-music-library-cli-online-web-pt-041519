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
    gets.chomp
    gets.chomp
    gets.chomp
    gets.chomp
  end
  
  def list_songs
    counter = 0
    song_library = Song.all.collect do |song|
      [song.artist.name, song.name, song.genre.name]
    end

    sorted = song_library.sort {|a, b| a[1][0] <=> b[1][0]}
    
    binding.pry
    numbered = sorted.collect do |song|
      counter += 1
      ["#{counter}. " + song[0], song[1..-1]].flatten
    end

    final_list = numbered.collect do |song|
      song.join(" - ")
    end

    final_list.each do |song|
      puts song
    end
    
  
  end
  
  def list_artists
    counter = 0
    artists = Artist.all.collect do |artist|
      artist.name
    end
    
    #artists is an array of artist names
    sorted_artists = artists.sort {|a, b| a <=> b}
    
    numbered_artists =
      sorted_artists.collect do |artist|
        counter += 1 
        artist = "#{counter}. " + artist
      end

    numbered_artists.each do |artist|
      puts artist
    end

  end
  
  def list_genres
    genres = Genre.all.collect do |genre|
      genre.name
    end
    counter = 0
    
    sorted_genres = genres.sort {|a, b| a <=> b}
    numbered_genres =
      sorted_genres.collect do |genre|
        counter +=1
        genre = "#{counter}. " + genre
      end

    numbered_genres.each do |genre|
      puts genre
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    counter = 1
    
    songs_array = Song.all.collect do |song|
      [song.name, song.artist, song.genre]
    end

      
    # songs_array = @importer.collect do |song|
    #   song.split(" - ")
    # end
  
    
    # returns a nested array of all songs by artist
    by_artist = songs_array.select {|song| song[0] == artist}
    
    # removes the artist from the beginning of each song array
    removed_artist =
      by_artist.collect do |song|
        song.drop(1)
      end
    
    # sorted is an array of song arrays
    sorted = removed_artist.sort {|a, b| a <=> b}
    
    # adds 1-4 to the beginning of each song array
    sorted.collect do |song|
      song.unshift("#{counter}.")
      counter += 1
    end
    
    # removes mp3 from the end, combines counter with song[1]
    nompthree = sorted.collect do |song|
      song[2].gsub!(/(.mp3)/, "")
      song[1] = song[0] + " " + song[1]
      song
    end
  
    # drops the first item from the array (the extra number)
    dropped = nompthree.collect do |song|
      song.drop(1)
    end
    
    # adds the hyphen back in
    withhyphen = dropped.collect do |song|
      song.join(" - ")
    end
    
    # puts each song out
    withhyphen.each do |song|
      puts song
    end
    
    

  end

    
end