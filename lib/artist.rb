require 'pry'

class Artist
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end
  
  def genres
    Genre.songs.select{|artist| genre.artist == self}
  end

  def add_song(song)
    song.artist = self if !song.artist
    @songs << song if !songs.include?(song)
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(artist_name)
    artist = Artist.new(artist_name)
    artist.save
    artist
  end
end
