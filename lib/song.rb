require "pry"
class Song
attr_accessor :name
attr_reader :artist, :genre
@@all = []

def initialize(name, artist = nil, genre = nil)
  @name = name
  self.artist = artist if artist
  self.genre = genre if genre
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
  song = Song.new(name)
  song.save
  song
end

def artist=(artist)
  @artist = artist
  @artist.add_song(self)
end

def genre=(genre)
  @genre = genre
  genre.songs << self unless genre.songs.include?(self)
end

def self.find_by_name(name)
  @@all.find{|songs| songs.name == name}
end

def self.find_or_create_by_name(name)
  self.find_by_name(name) || self.create(name)
end

def self.new_from_filename(path)
 song = self.new(path.split(" - ")[1])
 artist = Artist.find_or_create_by_name(path.split(" - ")[0])
 genre = Genre.find_or_create_by_name(path.split(" - ")[2].gsub(".mp3",""))
 song.artist = artist
 song.genre = genre
 song
end

def self.create_from_filename(path)
  song = self.new_from_filename(path)
  song.save
end

end
