class Genre 
  attr_accessor :name,:songs ,:song
  @@all = []
  extend Concerns::Findable
  def initialize(name)
  @name = name 
  @songs = []
  
end
  
  def self.all 
    @@all 
  end 
  def artists
    artist = songs.collect{|song| song.artist}
    artist.uniq 
  end
  
  def self.destroy_all 
    @@all.clear
  end
  def add_song(song)
    if songs.include?(song)== false 
       songs << song
      if song.genre == nil 
         song.genre = self 
      end
    end
  end
    
  def save
    @@all << self
  end
  
  def self.create(genre_name)
    genre = Genre.new(genre_name)
    genre.save
    genre
  end
    
end
