require 'pry'

class Song 
  
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :genre, :artist 
  @@all = [] 
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    if artist != nil 
      self.artist=(artist)
    end 
    if genre != nil 
      self.genre=(genre)
    end 
  end 
  
  def artist=(artist)
    @artist = artist 
    self.artist.add_song(self) 
  end 
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
  end 
  
  # def self.find_by_name(name)
  #   @@all.find {|song| song.name == name}
  # end 
  
  # def self.find_or_create_by_name(name)
  #   if self.find_by_name(name) != nil 
  #     self.find_by_name(name)
  #   else 
  #     self.create(name)
  #   end 
  # end 
    
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
    song = self.new(name)
    song.save 
    song 
  end 
  
  def self.new_from_filename(file_name)
    file_array = file_name.sub(/\.[^.]+\z/, '').split(" - ")
    # removes the .mp3 extension and splits the filename into an array of strings [artist, song, genre] 
    song = self.find_or_create_by_name(file_array[1])
    song.artist = Artist.find_or_create_by_name(file_array[0])
    song.genre = Genre.find_or_create_by_name(file_array[2])
    song
  end 
  
  def self.create_from_filename(file_name)
    self.new_from_filename(file_name)
  end 

end 