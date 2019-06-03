require 'pry'

class Artist
  extend Concerns::Findable
  extend Concerns::Persistable::ClassMethods
  include Concerns::Persistable::InstanceMethods
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name, songs = [])
    @name = name
    @songs = songs
  end
  
  def self.all
    @@all
  end

  def self.create(name)
    artist_instance = self.new(name)
    artist_instance.save
    artist_instance
  end
  
  def songs
    @songs
  end
  
  def add_song(song)
    if !song.artist
        song.artist = self
    end
    
    if !@songs.include?(song)
      @songs << song
      binding.pry
    end
  end
  
  def genres
    return_value = @songs.collect {|song| song.genre}
    return_value.uniq
  end
  
  
  
end
