require 'pry'
class Song 
  extend Concerns::Findable
  
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist= nil, genre= nil)
    Song.all.find {|item| item.name == name} == nil ? self.name = name : nil
    artist != nil ? self.artist=(artist) : nil
    genre !=nil ? self.genre=(genre) : nil
    @@all << self
  end 
  
  def save
    self.class.all << self
  end 
  
  def self.all
    @@all
  end   
  
  def artist=(artist)
    @artist = Artist.find_or_create_by_name(artist)
    @artist.add_song(self)
  end  
  
  def genre=(genre)
    @genre = Genre.find_or_create_by_name(genre)
    @genre.add_song(self)
  end    
  
  def self.new_from_filename(file)
    #binding.pry
    song = Song.new(file.split(" - ")[1])
    song.artist=(file.split(" - ")[0])
    song.genre=(file.split(" - ")[2].chomp(".mp3"))
    song
    #binding.pry
  end 
  
  def self.create_from_filename(file)
     self.new_from_filename(file).save
  end
  
end  