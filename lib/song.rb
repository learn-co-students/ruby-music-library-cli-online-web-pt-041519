require 'pry'
class Song 
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil 
    self.genre = genre if genre != nil
  end 
  
  def self.all
    @@all 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.destroy_all
    self.all.clear
  end 
  
  def self.create(name)
    Song.new(name).tap {|s| s.save}
  end 
  
  def self.new_from_filename(file)
    song_data = file.split(" - ")
    name = song_data[1]
    artist = song_data[0]
    genre = song_data[2].chomp(".mp3")
    
    song = Song.new(name)
    song.artist = Artist.find_or_create_by_name(artist)
    song.genre = Genre.find_or_create_by_name(genre)
    song
  end 
  
  def self.create_from_filename(file)
    new_from_filename(file).save
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self) unless artist.songs.include?(self)
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self)
  end 
  
end 
