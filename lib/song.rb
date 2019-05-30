require 'pry'
class Song
  extend Findable::ClassMethods
  extend Persistable::ClassMethods
  include Persistable::InstanceMethods
  
  attr_accessor :name
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
  
  def self.all
    @@all
  end
  
  def self.create(name)
    song_instance = self.new(name)
    song_instance.save
    song_instance
  end
  
  def artist
    @artist
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre
    @genre
  end
  
  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
  end
  
  def self.find_by_name(name)
    self.all.detect { |song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    finder = self.find_by_name(name)
    if !finder
      self.create(name)
    else
      return finder
    end
  end
  
  
  
  
end
