require 'pry'
class Song
  extend Concerns::Findable
  extend Concerns::Persistable::ClassMethods
  include Concerns::Persistable::InstanceMethods
  
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
  
  def self.new_from_filename(filename)
    split_filename = filename.split(/ - |(.mp3)/)
    new_or_existing_genre = Genre.find_or_create_by_name(split_filename[2])
    new_or_existing_artist = Artist.find_or_create_by_name(split_filename[0])
    song_instance = self.new(split_filename[1], new_or_existing_artist, new_or_existing_genre)
    song_instance
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
  
end