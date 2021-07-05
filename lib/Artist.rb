require_relative './Concerns/Findable'

class Artist 
  
  extend Concerns::Findable
  
  @@all = []
  
  attr_accessor :name
  attr_reader :songs
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def genres
    @songs.map {|song| song.genre}.uniq
  end
  
  def add_song(song)
    song.artist = self unless song.artist 
    @songs << song unless @songs.include?(song)
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
  
  def self.create(name)
    self.new(name).tap(&:save)
  end
  
end