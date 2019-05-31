
require_relative '../concerns/concerns.rb'
class Genre
  attr_accessor :artist, :song, :name
  @@all = []
  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save 
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
  def songs
    # Song.all.select do |song|
    #   song.genre == self
    # end
    @songs
  end

  def artists
    Song.all.map do |song|
      song.artist
    end
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(type)
    self.new(type).tap{|gen| gen.save}
  end
  
  def add_song(song)
    if song.genre != self
      song.genre = self
    end
    
    if !songs.include?(song) 
      songs << song
    end 
  end
  
  def artists 
    @artists = []
    self.songs.each do |song|
      @artists << song.artist
    end
    @artists.uniq
  end
end