
require_relative '../concerns/concerns.rb'

class Artist
  attr_accessor :name, :song, :genre
  @@all = []
  

  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
    save
  end
  
  def save 
    @@all << self 
  end
  
  def self.all 
    @@all
  end
  
  def new_song(name, genre)
    song = Song.new(name, self, genre)
    self.songs.last
  end

  def songs
    # Song.all.select do |song|
    #   song.artist == self
    # end
    @songs
  end

  def genres
    Song.all.map do |song|
      song.genre
    end
  end
  
  def self.destroy_all
    @@all.clear 
  end
  
  def self.create(art_name)
    self.new(art_name)
  end
  
  def add_song(song)
    if song.artist != self
      song.artist = self
    end
    
    if !songs.include?(song) 
      songs << song
    end 
  end
  
  def genres 
    @genres = []
    self.songs.each do |song|
      @genres << song.genre
    end
    @genres.uniq
  end
end