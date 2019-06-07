require 'pry'
class MusicLibraryController
  
  attr_accessor :path, :artist, :genre, :library
  
  def initialize(path = "./db/mp3s")
    @library = MusicImporter.new(path).import
    #binding.pry
  end  
  
  def call 
    puts "Welcome to your music library!"
    command = ""
    
    until command == "exit"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      command = gets.chomp
      
      case command
      
      when "list songs"
        self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      end 
    end
  end  
  
  
  def list_songs
    Song.all.collect{|song|song.name}.uniq.sort.collect{|name|Song.find_by_name(name)}.each_with_index{|song,index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}

    #@library.sort_by!{|song|song.scan(/-\s[a-zA-Z]+/).first}.each_with_index{|song, index| puts "#{index + 1}. #{song.split(" - ")[0]} - #{song.split(" - ")[1]} - #{song.split(" - ")[2].chomp(".mp3")}"}
  end  
  
  def list_artists
    Artist.all.collect{|artist|artist.name}.uniq.sort.collect{|name|Artist.find_by_name(name)}.each_with_index{|artist,index| puts "#{index + 1}. #{artist.name}"}
  end  
  
  def list_genres
    Genre.all.collect{|genre|genre.name}.uniq.sort.collect{|name|Genre.find_by_name(name)}.each_with_index{|genre, index| puts "#{index + 1}. #{genre.name}"}
  end  
  
  def list_songs_by_artist
    #binding.pry
    puts "Please enter the name of an artist:"
    a = Artist.find_by_name(gets)
    if a != nil 
       a.songs.collect{|song|song.name}.sort.collect{|name|Song.find_by_name(name)}.each_with_index{|song,index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end  
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    g = Genre.find_by_name(gets)
    if g != nil 
      g.songs.collect{|song|song.name}.sort.collect{|name|Song.find_by_name(name)}.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end  
  end  
  
  def play_song
    puts "Which song number would you like to play?"
    if gets.to_i > 0 && gets.to_i < @library.length 
      input = gets.to_i
      @library.sort_by!{|song|song.scan(/-\s[a-zA-Z]+/).first}
      a = @library[input - 1].split(" - ")[1]
      b = @library[input - 1].split(" - ")[0]
      puts "Playing #{a} by #{b}"
    else 
        nil
    end
  end  
  
end  