class Genre
  extend Findable::ClassMethods
  extend Persistable::ClassMethods
  include Persistable::InstanceMethods
  
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    genre_instance = self.new(name)
    genre_instance.save
    genre_instance
  end
  
  def songs
    @songs
  end
  
  def artists
    artists_collection = @songs.collect {|song| song.artist}
    artists_collection.uniq
  end
      
  
  
  
end
