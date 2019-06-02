require 'pry'

class Song 
  
  extend Concerns::Findable
  
  @@all = []
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def save
    @@all << self
  end
  
  def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist, name, genre = info[0], info[1], info[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    Song.new(name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    self.new(name).tap(&:save)
  end

end