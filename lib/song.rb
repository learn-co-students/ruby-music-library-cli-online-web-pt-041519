require 'pry'

class Song 

  attr_accessor :name
  attr_reader :artist, :genre 
  
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil 
      self.artist = artist
    end 
    if genre != nil
      self.genre = genre
    end 
  end 

  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(name)
    created_song = Song.new(name)
    created_song.save 
    created_song
  end 

  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.add_song(self)
  end 
  
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end 
  
  def self.new_from_filename(filename)
    file = filename.gsub(".mp3", "").split(" - ")
    artist = Artist.find_or_create_by_name(file[0])
    genre = Genre.find_or_create_by_name(file[2])
    self.new(file[1], artist, genre)
  end 
  
  def self.create_from_filename(filename)
    new = self.new_from_filename(filename)
    new.save 
  end 
  
end 

